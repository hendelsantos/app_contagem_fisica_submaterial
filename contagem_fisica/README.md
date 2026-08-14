# Contagem Física HMB — App Flutter

App Android **offline** para contagem física de materiais anti-erro, com exportação de Excel compatível com o Streamlit HMB (`core/importers.py::importar_stock_operador`).

> Especificação funcional completa: ver `../PLANO_APP_FLUTTER_CONTAGEM.md`.

## Decisões do MVP (confirmadas)

| Item | Decisão |
|---|---|
| Divergências (aumento sem recebimento) | Permite com justificativa + foto |
| Tolerância de aumento | `max(2% do estoque anterior, 1 Kg/L)` |
| Foto obrigatória | Apenas em divergências/justificativas |
| Recebimento múltiplo NFs/GRs | Sim, soma deve bater com total |
| Estoque sistêmico | Não usado no MVP |
| Primeira referência de estoque | Digitada pelo operador no primeiro uso |
| Excel final | Idêntico ao Streamlit + aba "Auditoria App" |
| QR/barcode | Não no MVP |
| Uso do aparelho | Exclusivo por operador |
| Saídas | Excel + PDF de auditoria |
| Banco local | SQLite/Drift |
| Stack UI/estado | Material 3 + Riverpod + go_router |

## Stack

- **Flutter** 3.24 (Dart 3.5)
- **Drift** (SQLite) — `lib/data/`
- **Riverpod** 2 + **go_router** 14
- **excel** 4 — geração do `.xlsx`
- **pdf** + **printing** — relatório de auditoria
- **image_picker** — fotos de divergência
- **share_plus** — compartilhar arquivos gerados

## Estrutura

```
lib/
├── main.dart                    # bootstrap com ProviderScope
├── app.dart                     # MaterialApp.router
├── data/
│   ├── tables.dart              # tabelas Drift (@DataClassName)
│   ├── database.dart            # AppDatabase + queries
│   └── seed.dart                # MATERIAIS_INICIAIS + fornecedores
├── domain/
│   ├── models.dart              # DTOs (MaterialDTO, ItemContagemDTO, ...)
│   ├── validacao.dart           # regras anti-erro (item 6 do plano)
│   ├── export_excel.dart        # GeradorExcel -> .xlsx compatível
│   └── export_pdf.dart          # GeradorPdf -> relatório
├── providers/
│   ├── database_provider.dart
│   ├── materiais_provider.dart
│   └── sessao_provider.dart     # sessaoAtualProvider, itens, resumos
└── ui/
    ├── router.dart              # GoRouter com redirect por sessão
    ├── setup_operador_page.dart # início de turno (nome do operador)
    ├── home_page.dart           # cards por fornecedor
    ├── fornecedor_page.dart     # materiais do fornecedor
    ├── material_page.dart       # contagem guiada (coração do app)
    ├── resumo_page.dart         # resumo final antes de exportar
    └── export_page.dart         # gera Excel + PDF, compartilha
```

## Como rodar

```bash
cd contagem_fisica
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # gera *.g.dart do Drift
flutter run                                   # dispositivo/emulador
flutter test                                  # testes das regras anti-erro
flutter analyze                               # lint estático
flutter build apk --debug                     # APK de teste
flutter build apk --release                   # APK para instalar no aparelho
```

Para regenerar código Drift após editar `lib/data/tables.dart` ou `database.dart`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Fluxo do app

1. **Setup**: operador informa apenas o nome; o app registra o início pela hora do celular.
2. **Home**: cards por fornecedor (Henkel, PPG, Shinsung, Wax, Axalta) com
   contadores (total / contados / pendentes / alertas / bloqueios).
3. **Fornecedor**: lista materiais cadastrados (unidade fixa, código, família) e mostra o horário salvo de cada material contado.
4. **Material (guiado)**: digita estoque anterior (1ª vez), estoque contado,
   recebimento total; adiciona NFs/GRs; anexa foto e justificativa se
   divergência. As regras anti-erro bloqueiam conclusão se houver problema.
5. **Resumo**: mostra andamento completo, bloqueia exportação enquanto houver
   material pendente/bloqueado.
6. **Exportar**: gera `.xlsx` compatível com Streamlit (Stock do Operador) +
   PDF de auditoria com horário por material. Compartilha via `share_plus`,
   incluindo envio do Excel pelo WhatsApp. Quando o APK for gerado com
   `BACKEND_URL` e `APP_API_TOKEN`, a tela também envia os dados da contagem
   para o backend online.

## Envio online

O envio online é opcional. Para gerar um APK que envia a contagem para o
backend quando houver internet:

```bash
flutter build apk --release \
  --dart-define=BACKEND_URL=https://backend-production-3a35.up.railway.app \
  --dart-define=APP_API_TOKEN=<token-do-backend>
```

Sem esses `dart-define`, o app continua 100% offline e mostra o envio online
como desativado.

## Compatibilidade do Excel

O Excel gerado respeita o layout esperado por
`core/importers.py::_importar_stock_workbook`:

- Abas: `Estoque Henkel`, `Estoque PPG`, `Estoque Shinsung`, `Estoque Wax`,
  `Estoque Axalta`.
- Linha 1: `"Data"` em A1 (mesclado verticalmente) + nome do material
  (`nomeStock`) mesclado nas colunas do bloco — mesmo padrão da planilha
  original (`C-AK 1552`, `Resina`, etc., compatível com `STOCK_CODE_MAP`).
- Linha 2: sub-cabeçalhos `Inventário (Containers)` (mesclado), `Total (KG)`,
  `Estoque sistêmico`, `Recebimentos`.
- Linha 3: numeração de containers 1..6.
- Linhas 4 e 5: **duas linhas no período** (abertura e fechamento):
  - Linha 4 (`data_inicio`): `Total = estoque_anterior`, `Recebimentos = 0`.
  - Linha 5 (`data_fim`): `Total = estoque_contado`, `Estoque sistêmico = 0`
    (não usado no MVP), `Recebimentos = soma das NFs/GRs`.

Isso faz o importador computar corretamente:
- `estoque_inicial_fisico_stock = estoque_anterior`
- `estoque_final_fisico_stock = estoque_contado`
- `recebimento_stock_kg = soma das NFs/GRs`

Abas extras: `Auditoria App` (não interfere no importador).

## Regras anti-erro implementadas (`lib/domain/validacao.dart`)

- Material fechado: só pode contar do cadastro (sem digitação livre).
- Estoque contado / recebimento / NF não podem ser negativos.
- Recebimento > 0 exige ao menos uma NF/GR.
- Soma das NFs/GRs deve bater com recebimento total.
- Aumento de estoque sem recebimento é bloqueado acima da tolerância
  `max(2% do estoque_anterior, 1 Kg/L)`. Libera apenas com
  justificativa **+ foto**.
- Consumo físico impossível (consumo negativo acima da tolerância) sinaliza
  divergência e exige foto.
- Foto obrigatória em divergências (item 6.8 do plano).
- Continuidade: ao concluir um item válido, `estoque_contado` vira referência
  (`estoqueReferencia`) para a próxima sessão daquele material.

## Teste

`test/widget_test.dart` cobre as regras anti-erro principais. Rode:
`flutter test`.

## Roadmap (após MVP)

- Fase 2: dupla contagem para itens críticos + aprovador de divergências.
- Fase 3: importar cadastro mestre JSON + estoque de referência JSON
  exportados pelo Streamlit.
- Fase 4: API FastAPI para envio direto (fila offline).

## Fora do escopo do MVP

- Escrita direta no `data/submaterial.sqlite3` do Streamlit.
- Leitura de QR/barcode.
- Cálculo de BOM por modelo/cor.
- Login corporativo.
- Integração automática com SAP.
