# Plano de Continuação — App Contagem Física HMB

Status em 12/08/2026. Use este doc para retomar o trabalho exatamente de onde paramos.

## Versão atual

- **Release latest:** v0.4.0 (https://github.com/hendelsantos/app_contagem_fisica_submaterial/releases/latest)
- **pubspec.yaml:** `0.6.1+11` local em desenvolvimento. Falta criar GitHub Release se o `gh auth` não for concluído.
- **Página de download:** https://hendelsantos.github.io/app_contagem_fisica_submaterial/  (automática via `releases/latest`)
- **QR code aponta para:** a página acima (fixo).

## Concluído até aqui

| Versão | Resumo |
|---|---|
| v0.1.0 | MVP Fase 1 — contagem guiada, validações anti-erro, Excel + PDF, GitHub Pages. |
| v0.1.1 | Corrigida unidade Axalta: Kg → L. |
| v0.2.0 | Ponderamento automático do estoque anterior + tela Sobre. |
| v0.3.0 | Foto da divergência vira opcional (observação escrita basta). |
| v0.3.1 | Tela Sobre mostra histórico de versões (lê `CHANGELOG.md` embarcado). |
| v0.3.2 | Backup e restauração JSON do banco local (tela `/backup`, share_plus, file_picker). |
| v0.3.3 | Histórico/auditoria por item — tabela `itens_historico`, tela `/historico`, snapshot por edição. |
| v0.4.0 | Admin de parâmetros — tela `/admin` com PIN (SHA-256), tolerâncias configuráveis, consumo diário esperado por material, painel de alertas. |
| v0.5.0 | Pacote ZIP de auditoria — Excel + PDF + pasta `fotos/` e manifesto de fotos. |
| v0.6.0 | Backend Django/MySQL no Railway + envio da contagem pelo app via API. |
| v0.6.1 | Correção backend — números das NFs passam a ser persistidos e exibidos no dashboard/API. |

## Próximos passos (fila)

### 1. Fechar publicação GitHub
- `v0.5.0`: commit/tag/push feitos. Falta GitHub Release se `gh auth` não for concluído.
- `v0.6.1`: gerar APK com `--dart-define=BACKEND_URL=... --dart-define=APP_API_TOKEN=...`, commit, tag e release.

### 2. Próximo polimento backend/app
- Dashboard Django no Railway publicado em `https://backend-production-3a35.up.railway.app`.
- Banco MySQL no Railway.
- Login dashboard: `hendel` / `admin123` (trocar depois).
- Endpoints:
  - `POST /api/contagens/` recebe JSON da sessão completa + itens + notas.
  - `GET /api/contagens/` lista contagens para usuário logado.
  - `GET /api/contagens/{id}/` detalhe.
- NFs: tabela `NotaRecebimento`; números aparecem no detalhe da contagem e na API.
- Próximo passo técnico: transformar o botão do app em envio automático após gerar pacote, se o fluxo real pedir.

### 3. Itens menores (pode fazer antes do backend, se aparecer prioridade)
- Importar cadastro mestre JSON do Streamlit (`materiais.json`) — tela `/importar_cadastro`. Substitui seed fixo. **Decidido: deixar pra depois, manter seed.dart por enquanto.**
- QR/barcode nos containers (`mobile_scanner` package) — pular busca manual.
- Aprovador para divergências grandes (segundo operador).

### 4. Polimento/bugfix conforme uso real
- Ajustar textos da tela Sobre conforme feedback do operador.
- Detectar inconsistência entre soma de NFs e recebimento com tolerância configurável.
- Suporte a aparelho compartilhado (vários operadores mesma sessão).

## Ambiente/Comandos

```bash
# Rodar local
cd contagem_fisica && flutter run

# Testes
cd contagem_fisica && flutter test

# Análise estática
cd contagem_fisica && flutter analyze

# Regenerar Drift (sempre após editar tables.dart ou database.dart)
cd contagem_fisica && dart run build_runner build --delete-conflicting-outputs

# APK release
cd contagem_fisica && flutter build apk --release
# -> contagem_fisica/build/app/outputs/flutter-apk/app-release.apk
```

## Fluxo de release (a partir da v0.3.1)

1. Editar `contagem_fisica/CHANGELOG.md` adicionando seção `## X.Y.Z`.
2. Bump `version:` em `contagem_fisica/pubspec.yaml`.
3. `flutter analyze` + `flutter test` (precisa passar).
4. `flutter build apk --release`.
5. `git add -A && git commit -m "vX.Y.Z: <resumo>" && git push origin main`.
6. `git tag -a vX.Y.Z -m "..." && git push origin vX.Y.Z`.
7. Criar release no GitHub (gh CLI ou site), anexar `app-release.apk`, notes = conteúdo do `CHANGELOG.md` daquela versão.
8. A página de download atualiza SOZINHA (busca `releases/latest`).

## Notas operacionais

- **gh CLI instalado em:** `/tmp/opencode/gh/gh_2.63.2_linux_amd64/bin/gh` (binário portátil; somado ao PATH só nesta sessão). Não persiste entre reinícios — reinstalar se precisar.
- **Token atual:** classic PAT `ghp_...` (escopo `repo`). **Revogar** em github.com/settings/tokens ao final da sessão e gerar novo quando precisar criar Release via linha de comando.
- **Remote:** `git@github.com:hendelsantos/app_contagem_fisica_submaterial.git` (SSH já configurado no aparelho de dev).
- **Regras de foto:** desde v0.3.0 a foto é opcional. Regra em `lib/domain/validacao.dart` (apenas observação escrita exige justificativa).
- **Backup:** inclui `itens_historico` desde v0.3.3 (backup versão 2). Fotos NÃO incluídas (só caminho) — item 1 acima vai resolver isso.
- **Admin/PIN:** desde v0.4.0. PIN padrão `0000`, trocável pela tela `/admin`. Hash SHA-256 guardado na tabela `parametros` (linha singleton id=1). Tolerâncias (pct e min_kg) e janela de alerta configuráveis. Consumo diário esperado por material em `consumo_esperado`. Alertas disparam quando consumo real da última sessão finalizada foge de [50%, 150%].

## Decisões pendentes (perguntar ao Hendel quando retomar)

1. Login do backend: confirmar `hendel/admin123` em usuário único (decidido nesta sessão, mas vale revisar quando for implementar de fato).
2. Cadastro mestre: confirmar que Streamlit pode exportar `materiais.json` no layout do item 11.1 do plano? (Adiado.)
