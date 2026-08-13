# Changelog — Contagem Física HMB

## 0.7.2
- Tela inicial simplificada: o operador informa apenas o nome.
- Início da sessão passa a usar automaticamente a hora do celular.
- Cada material exibe o horário registrado pelo celular na ficha e na lista do fornecedor.
- Excel e PDF deixam explícito o horário de registro por material para auditoria.

## 0.7.1
- Tela Exportar ganha ação direta **Enviar Excel pelo WhatsApp** após gerar a contagem.
- O envio compartilha apenas o arquivo Excel, facilitando o fluxo operacional com WhatsApp.

## 0.7.0
- Removido o envio direto para backend/Railway do app.
- Tela Exportar volta a focar no pacote local: ZIP de auditoria, Excel e PDF compartilháveis.
- Removida dependência direta `http`.
- Decisão operacional: sem servidor obrigatório para o fluxo de contagem.

## 0.6.1
- Backend passa a persistir e exibir os números das notas fiscais de recebimento.
- API de detalhe retorna `itens[].notas[]` com número, quantidade, data e caminho de foto.
- Tela de detalhe do dashboard mostra as NFs vinculadas a cada material.

## 0.6.0
- Adicionado envio dos dados da contagem para o backend Django no Railway.
- Tela Exportar ganha o botão **Compartilhar dados no backend**.
- Payload enviado inclui sessão, itens, materiais, status, justificativas, fotos referenciadas e notas fiscais.
- Backend configurado por `--dart-define=BACKEND_URL` e `--dart-define=APP_API_TOKEN`, evitando gravar token no repositório.
- Nova dependência direta: `http`.

## 0.5.0
- Exportacao gera um pacote ZIP de auditoria com Excel, PDF e pasta `fotos/`.
- Fotos de contagem, justificativa e notas fiscais sao copiadas para dentro do ZIP quando os arquivos ainda existem no aparelho.
- O ZIP inclui `manifesto_fotos.txt` relacionando cada foto exportada ao caminho original e apontando fotos ausentes.
- Tela Exportar passa a compartilhar o pacote completo, mantendo os cards separados de Excel e PDF.
- Nova dependencia direta: `archive`.

## 0.4.0
- Novo módulo **Admin de parâmetros** (tela `/admin`), acessível pela Home e pela tela de setup.
- Login por PIN (padrão de fábrica `0000`, editável na própria tela).
  - PIN é guardado hasheado com SHA-256 no banco SQLite (nunca em texto plano).
  - Troca de PIN exige informar o PIN atual e confirmação do novo (mín. 4 dígitos).
- Parâmetros globais configuráveis (tabela `parametros`, singleton):
  - `tolerancia_pct` (fração do estoque anterior, ex: 0.02 = 2%).
  - `tolerancia_min_kg` (mínimo absoluto em Kg/L).
  - `alerta_janela` (`diaria` ou `semanal`).
- Consumo diário esperado por material (tabela `consumo_esperado`, cadastrado manualmente no admin).
- Painel de Alertas: consumo real fora de [50%, 150%] do esperado na última sessão finalizada.
- `domain/validacao.dart` passa a ler tolerâncias dos parâmetros (em vez de constantes fixas). Defaults preservam comportamento anterior (2% / mínimo 1 Kg/L).
- Novas dependências: `crypto` (hash do PIN).
- schemaVersion 4 (migration cria `parametros` e `consumo_esperado` com defaults).

## 0.3.3
- Novo módulo **Auditoria do item** (tela /historico).
- Cada adição/edição de item agora grava um registro de histórico com:
  - operador que alterou, ação (`criado`/`editado`), timestamp,
  - snapshot dos valores naquele momento (estoque anterior, contado, recebimento, status, justificativa).
- Botão de auditoria na tela do material (ícone history na AppBar).
- Tela de auditoria mostra timeline em ordem cronológica reversa, com chips coloridos por status.
- Backup passa a incluir e restaurar o histórico (backup versão 2).
- Nova tabela Drift `itens_historico` (schemaVersion 3).

## 0.3.2
- Novo módulo **Backup e Restauração** (tela /backup).
- Botão de backup na barra superior da Home.
- `exportarBackup` serializa todas as tabelas do banco SQLite (materiais, fornecedores, sessões, itens, notas fiscais, referências de estoque e exports) em um arquivo JSON.
- `importarBackup` carrega arquivo JSON escolhido pelo usuário via file_picker e substitui os dados do aparelho (após confirmação).
- Backup é compartilhável via share_plus (e-mail, nuvem, pen drive).
- Observação: fotos não são incluídas no backup (apenas o caminho).
- Adicionada dependência `file_picker`.

## 0.3.1
- Adicionada seção "Histórico de versões" na tela Sobre do app.
- Versão exibida no topo do Sobre passa a ser lida dinamicamente do changelog.
- CHANGELOG.md agora é embarcado como asset no APK.

## 0.3.0
- Foto de divergência agora é opcional.
- A divergência de "aumento sem recebimento" passa a ser considerada justificada apenas com a observação escrita (sem exigir foto).
- Removido o bloqueio que impedia concluir o item sem foto anexada.
- Função `fotoObrigatoria()` substituída por `requerJustificativa()` (usada apenas para exibir a seção de justificativa na UI).
- Botão atualizado para "Anexar foto (opcional)".
- Textos da tela Sobre atualizados ("exige justificativa + foto" → "exige justificativa por escrito (foto opcional)").
- Testes ajustados para a nova função `requerJustificativa()`.

## 0.2.0
- Ponderamento automático do estoque anterior (última contagem válida vira referência da próxima).
- Tela Sobre com explicação do fluxo, regras anti-erro, status e privacidade.
- Ajustes de UX na lista por fornecedor e no resumo final.

## 0.1.1
- Corrigida unidade dos materiais da Axalta: Kg → L (litros).

## 0.1.0
- MVP Fase 1 — contagem guiada por material, validações anti-erro, geração de Excel + PDF, exportação para Streamlit.
- Cadastro local com 29 materiais em 5 fornecedores (seed).
- Página pública de download via QR code (GitHub Pages).
