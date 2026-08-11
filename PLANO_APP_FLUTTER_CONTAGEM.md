# Especificação do App Flutter — Contagem Física à Prova de Erro

> Documento de especificação funcional para desenvolver um app Android em Flutter, preferencialmente em um repositório separado. O app deve apoiar a contagem física dos materiais no celular, reduzir erros no momento da operação e gerar um Excel compatível com o Streamlit atual.

## 1. Objetivo

Hoje o operador conta os materiais manualmente e preenche a planilha `Exemplos_planilha/Contagem fisica operador/Planilha stock 2026.xlsx`. Muitos erros só aparecem depois, quando o fechamento já está sendo processado no Streamlit:

- material digitado errado;
- unidade trocada;
- item esquecido;
- recebimento não informado;
- nota fiscal/GR sem vínculo com o item;
- estoque aumentando sem ter recebido material;
- diferença entre estoque contado hoje e estoque final anterior;
- falta de evidência visual quando há divergência.

**Objetivo do app:** guiar o operador no celular, fornecedor por fornecedor e material por material, impedindo o avanço quando houver erro evidente. Ao final, o app deve gerar um Excel no layout que o Streamlit já importa por `core/importers.py::importar_stock_operador`.

## 2. Decisão de arquitetura inicial

O app Flutter deve ser criado em **outro repositório/projeto**, separado do Streamlit.

Motivos:

- evita misturar código mobile com o app Streamlit atual;
- permite evoluir, compilar APK e versionar releases Android de forma independente;
- mantém o Streamlit rodando como sistema principal de fechamento;
- reduz risco para a operação atual.

Integração inicial:

1. O Flutter gera um Excel de contagem.
2. O usuário importa esse Excel no Streamlit, como já faz hoje.
3. Futuramente, se o fluxo estiver validado, pode ser criada uma API para envio direto.

**Não recomendado na Fase 1:** o app Android escrever direto no `data/submaterial.sqlite3`. Se houver integração direta no futuro, ela deve passar por uma API controlada.

## 3. Fonte da verdade das regras de negócio

As regras e cadastros não devem ser reinventados no app. O Flutter deve usar uma exportação do sistema Python/Streamlit.

| Informação/regra | Fonte atual no Streamlit | Uso no Flutter |
|---|---|---|
| Cadastro fechado de materiais | `core/materials.py::MATERIAIS_INICIAIS` ou tabela `materiais` no SQLite | Lista fechada. Operador não digita material livre. |
| Fornecedores | `core/importers.py::STOCK_SHEETS` | Cards de fornecedores: Henkel, PPG, Shinsung, Wax, Axalta. |
| Código, descrição, família, unidade, `sobe_sap` | `core/materials.py` / SQLite | Exibição e validação. Unidade não editável. |
| Layout do Excel de stock | `core/importers.py::importar_stock_operador` | Excel final deve respeitar abas e estrutura esperadas. |
| Estoque final anterior | último fechamento aprovado ou último Excel gerado/importado | Referência para validar continuidade. |
| Regra de aumento sem recebimento | `_detectar_aumentos_estoque_sem_recebimento` | Bloquear aumento sem recebimento ou exigir justificativa controlada. |
| Consumo/estoque negativo | `core/full_validation.py` / `core/review.py` | Bloquear valores negativos e consumo impossível. |

## 4. Fluxo operacional esperado

### 4.1 Início do turno

O operador chega cedo para realizar a contagem física antes do fechamento.

Ao abrir o app:

1. informa nome/matrícula;
2. seleciona o período da contagem;
3. confirma data/hora inicial e final;
4. carrega o cadastro de materiais;
5. carrega o estoque de referência anterior, quando disponível.

O app cria uma sessão local de contagem com:

- operador;
- data/hora de início;
- data/hora de fim prevista;
- status: em andamento, finalizada ou exportada;
- versão do cadastro usado;
- aparelho usado, se disponível.

### 4.2 Tela inicial da contagem

A tela principal deve mostrar cards por fornecedor:

- Henkel;
- PPG;
- Shinsung;
- Wax;
- Axalta.

Cada card deve mostrar:

- quantidade total de materiais do fornecedor;
- quantidade já contada;
- quantidade pendente;
- quantidade com alerta;
- status visual: pendente, em andamento, concluído, com bloqueio.

O operador entra em um fornecedor e conta os materiais daquele fornecedor.

### 4.3 Tela do fornecedor

Dentro do fornecedor, aparecem os materiais em cards ou lista guiada.

Cada material deve mostrar:

- código do material;
- descrição;
- família;
- unidade fixa: Kg ou L;
- estoque final anterior/reference;
- estoque sistêmico, se disponível;
- status do item: pendente, válido, com alerta, justificado.

O app deve permitir dois modos:

1. **Modo lista:** operador vê todos os materiais do fornecedor.
2. **Modo guiado:** app mostra um material por vez, com botão próximo.

Para MVP, o modo guiado é preferível, porque reduz item pulado.

## 5. Campos obrigatórios por material

Para cada material, o operador deve preencher:

| Campo | Obrigatório | Regra |
|---|---:|---|
| Estoque contado | Sim | Número >= 0. Unidade fixa do cadastro. |
| Recebimento total no período | Sim, pode ser 0 | Número >= 0. |
| Número da NF/GR | Obrigatório se recebimento > 0 | Texto ou número. Pode aceitar múltiplas notas. |
| Quantidade por NF/GR | Obrigatório se recebimento > 0 | Soma das quantidades deve bater com o recebimento total. |
| Foto do item/local | Recomendado; obrigatório em casos de alerta | Foto anexada ao item. |
| Observação | Obrigatória quando houver alerta/justificativa | Texto curto explicando a divergência. |

### 5.1 Recebimentos e notas fiscais

Se `Recebimento total no período > 0`, o app deve obrigar o operador a registrar pelo menos uma nota/GR.

Cada nota/GR deve conter:

- número da NF ou GR;
- quantidade recebida;
- data do recebimento, se souber;
- foto opcional da etiqueta/documento/local.

Validação:

```text
soma_quantidades_nf == recebimento_total_material
```

Se a soma das NFs for diferente do recebimento total, o app bloqueia o avanço.

## 6. Regras anti-erro obrigatórias

Estas regras devem rodar no celular antes de permitir concluir cada material.

### 6.1 Material fechado

O operador não pode criar ou digitar material manualmente na contagem oficial.

Permitido:

- selecionar material cadastrado;
- pesquisar por código ou descrição;
- futuramente ler QR/barcode e localizar material cadastrado.

Bloqueado:

- código inexistente;
- descrição livre;
- unidade manual.

### 6.2 Item não pode ficar sem contagem

Nenhum material ativo pode ficar pendente.

O app não deve permitir finalizar o fornecedor nem gerar Excel se existir:

- material sem estoque contado;
- material sem recebimento preenchido;
- material com alerta sem resolução;
- material com recebimento e sem NF/GR.

### 6.3 Valores negativos

Bloquear:

- estoque contado menor que zero;
- recebimento menor que zero;
- quantidade de NF/GR menor que zero.

### 6.4 Estoque não pode aumentar sem recebimento

Regra principal:

```text
aumento_sem_explicacao = estoque_contado_atual - estoque_anterior - recebimento_total
```

Se `aumento_sem_explicacao` for maior que a tolerância, o app deve bloquear o avanço.

Tolerância inicial sugerida:

```text
max(2% do estoque_anterior, 1 Kg/L)
```

Exemplo:

- ontem/última referência: 100 Kg;
- hoje contado: 130 Kg;
- recebimento: 0 Kg;
- aumento sem explicação: 30 Kg;
- resultado: bloqueado.

Mensagem sugerida:

```text
O estoque aumentou 30 Kg sem recebimento registrado. Confira o item, container e nota fiscal antes de continuar.
```

O operador deve:

1. corrigir o estoque contado; ou
2. informar recebimento e NF/GR; ou
3. abrir justificativa com foto, caso a empresa permita exceção.

Para MVP, recomenda-se permitir justificativa apenas com:

- observação obrigatória;
- foto obrigatória;
- marcação clara no Excel/relatório.

### 6.5 Continuidade entre dias/contagens

O estoque final de uma contagem deve virar a referência da próxima.

Regra:

```text
estoque_anterior_do_app = estoque_final_da_ultima_contagem_valida
```

Se o operador contou hoje e amanhã contar novamente, o app deve comparar com a última contagem salva no aparelho ou importada do Streamlit.

Exemplo:

- contagem anterior: 80 Kg;
- recebimento desde então: 0 Kg;
- nova contagem: 95 Kg;
- resultado: bloqueado ou exige justificativa, porque o estoque aumentou sem recebimento.

### 6.6 Consumo impossível

Consumo estimado:

```text
consumo = estoque_anterior + recebimento_total - estoque_contado_atual
```

Bloquear quando:

- consumo calculado for negativo além da tolerância;
- estoque contado for incoerente com recebimento;
- recebimento informado não tiver NF/GR.

### 6.7 Unidade fixa

A unidade vem do cadastro do material.

O operador não pode alterar Kg/L. A tela deve sempre deixar a unidade visível ao lado do campo.

### 6.8 Foto obrigatória para divergências

Foto deve ser obrigatória quando ocorrer:

- aumento sem recebimento;
- diferença grande contra estoque anterior;
- recebimento com NF/GR duvidosa;
- ajuste manual/justificativa;
- item crítico definido pela empresa.

As fotos devem ficar salvas localmente e referenciadas no relatório de auditoria. O Excel pode conter apenas o nome/caminho da foto, se embutir imagem no Excel ficar pesado para o MVP.

## 7. Produção por modelo e cor

O usuário cogitou informar produção do período por modelo e cor para o app calcular consumo esperado no celular.

Isso é possível, mas deve ser tratado como **opcional** no MVP.

Motivo:

- a prioridade do app é reduzir erro de contagem física e recebimento;
- produção por modelo/cor aumenta a complexidade;
- o Streamlit já faz o fechamento completo usando Paint Out e BOM.

Recomendação:

### MVP

Não exigir produção por modelo/cor no app.

O app pode calcular apenas:

```text
consumo_fisico_estimado = estoque_anterior + recebimento - estoque_contado
```

### Evolução futura

Adicionar módulo opcional de produção:

- modelo;
- cor;
- quantidade produzida;
- período;
- consumo teórico por BOM;
- comparação entre consumo físico e consumo esperado.

Esse módulo só deve entrar se a operação realmente precisar enxergar o consumo antes de importar no Streamlit.

## 8. Resumo final antes de exportar

Antes de gerar o Excel, o app deve mostrar um resumo:

- fornecedores concluídos;
- materiais contados;
- materiais com recebimento;
- materiais com NF/GR;
- alertas corrigidos;
- alertas justificados;
- fotos pendentes;
- materiais sem foto quando foto for obrigatória;
- consumo físico estimado por material;
- divergências relevantes.

O botão **Gerar Excel** só deve habilitar quando:

- todos os fornecedores estiverem concluídos;
- todos os materiais ativos estiverem contados;
- todas as validações bloqueantes estiverem resolvidas;
- recebimentos tiverem NF/GR;
- fotos obrigatórias tiverem sido anexadas.

## 9. Excel final

O Excel gerado pelo app deve ser compatível com o importador atual:

- mesmas abas de `STOCK_SHEETS`;
- mesmos fornecedores;
- mesmos blocos por material;
- campos necessários para `Total`, `Recebimentos` e `Estoque sistêmico`;
- datas no intervalo selecionado;
- valores numéricos sem formatação ambígua.

Além do Excel compatível com o Streamlit, o app pode gerar uma aba extra de auditoria, desde que isso não quebre o importador.

Aba extra sugerida: `Auditoria App`

Campos:

- operador;
- data/hora da contagem;
- fornecedor;
- material código;
- material descrição;
- estoque anterior;
- estoque contado;
- recebimento total;
- NF/GR;
- quantidade por NF/GR;
- alerta gerado;
- justificativa;
- foto(s);
- timestamp do item.

## 10. Dados locais do app

O app deve funcionar offline.

Dados salvos no aparelho:

- cadastro de materiais;
- fornecedores;
- sessões de contagem;
- itens contados;
- recebimentos por NF/GR;
- fotos;
- justificativas;
- histórico da última contagem válida por material;
- arquivos Excel gerados.

Banco local sugerido:

- SQLite/Drift; ou
- Isar/Hive, se o time preferir simplicidade.

Para rastreabilidade, SQLite/Drift tende a ser melhor.

## 11. Exportações/importações auxiliares

Para manter o app sincronizado com o Streamlit, o projeto Python pode futuramente gerar arquivos auxiliares:

### 11.1 Cadastro mestre JSON

Exemplo:

```json
{
  "versao": "2026-08-11",
  "materiais": [
    {
      "codigo": "GB24020120109A074",
      "descricao": "Ridoline G1552 HY L",
      "fornecedor": "Henkel",
      "familia": "Pre-tratamento",
      "unidade": "Kg",
      "sobe_sap": 1,
      "ativo": true
    }
  ]
}
```

### 11.2 Estoque de referência JSON

Exemplo:

```json
{
  "periodo_fechamento": "2026-07",
  "data_referencia": "2026-07-31",
  "estoques": [
    {
      "material_codigo": "GB24020120109A074",
      "estoque_final_kg": 100.0,
      "estoque_sistemico_kg": 98.0
    }
  ]
}
```

## 12. Roadmap recomendado

### Fase 0 — Protótipo validado com operador

- desenhar telas principais;
- validar fluxo fornecedor -> material -> recebimento -> foto -> resumo;
- confirmar campos obrigatórios;
- confirmar tolerância;
- confirmar se justificativa pode liberar bloqueios.

### Fase 1 — MVP offline anti-erro

- app Android Flutter;
- cadastro local embutido/importável;
- cards por fornecedor;
- contagem guiada por material;
- recebimento com NF/GR;
- validações bloqueantes;
- foto para divergência;
- histórico da última contagem no aparelho;
- geração de Excel compatível com Streamlit.

### Fase 2 — Auditoria reforçada

- dupla contagem para itens críticos;
- segundo operador/aprovador para divergências;
- relatório de auditoria mais completo;
- exportação de pacote `.zip` com Excel + fotos.

### Fase 3 — Sincronização com Streamlit

- export JSON do Streamlit para cadastro e estoque referência;
- importação simples no app;
- tela de atualização de cadastro.

### Fase 4 — API direta

- FastAPI no computador/servidor da empresa;
- app envia contagem direto por rede;
- autenticação;
- fila offline quando sem rede;
- painel no Streamlit para revisar contagens recebidas.

## 13. Decisões que precisam ser confirmadas antes de codar

1. O app deve bloquear totalmente divergência ou permitir justificativa com foto?
2. A tolerância será mesmo `2% do estoque anterior, mínimo 1 Kg/L`?
3. Foto será obrigatória para todos os materiais ou apenas para divergências?
4. Recebimento pode ter múltiplas NFs/GRs por material?
5. O operador vai informar estoque sistêmico no app ou esse dado virá de arquivo exportado?
6. O primeiro estoque de referência virá do Streamlit, da planilha anterior ou será digitado no primeiro uso?
7. O Excel precisa ser exatamente igual ao layout atual ou podemos adicionar uma aba extra de auditoria?
8. Vai existir leitura de QR/barcode nos materiais/containers na primeira versão?
9. Um aparelho será usado por um operador ou vários operadores compartilharão o mesmo aparelho?
10. O app deve gerar apenas Excel ou também PDF/ZIP de auditoria?

## 14. Critérios de aceite do MVP

O MVP será considerado pronto quando:

- instalar em Android por APK;
- funcionar offline;
- listar fornecedores em cards;
- listar materiais corretos por fornecedor;
- impedir material pendente;
- impedir valores negativos;
- impedir aumento de estoque sem recebimento ou justificativa;
- exigir NF/GR quando houver recebimento;
- exigir foto quando houver divergência;
- salvar histórico local;
- gerar Excel importável pelo Streamlit sem alterar `core/importers.py`;
- permitir o operador revisar tudo antes de exportar.

## 15. Fora do escopo inicial

Não entra na primeira versão, salvo decisão contrária:

- envio direto para o banco SQLite;
- API online;
- cálculo completo de BOM por modelo/cor;
- login corporativo;
- aprovação por gestor dentro do app;
- dashboard mobile;
- integração automática com SAP.
