# Changelog — Contagem Física HMB

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