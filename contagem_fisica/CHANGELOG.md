# Changelog — Contagem Física HMB

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