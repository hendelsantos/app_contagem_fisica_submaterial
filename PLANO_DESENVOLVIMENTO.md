# Plano de Continuação — App Contagem Física HMB

Status em 12/08/2026. Use este doc para retomar o trabalho exatamente de onde paramos.

## Versão atual

- **Release latest:** v0.3.3 (https://github.com/hendelsantos/app_contagem_fisica_submaterial/releases/latest)
- **pubspec.yaml:** `0.3.3+7`
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

## Próximos passos (fila)

### 1. Espaço Admin de parâmetros com PIN (offline, ~2-3 dias)
- Nova tabela Drift `parametros` (singleton ou uma linha por material).
- Campos sugeridos:
  - `tolerancia_pct` (default 0.02)
  - `tolerancia_min_kg` (default 1.0)
  - `consumo_diario_esperado_kg` por material (nullable)
  - `alerta_janela` (`diaria` | `semanal`)
  - `pin_admin` (default `0000`) — guardado hasheado (SHA-256) no banco, barreira local no aparelho.
- `domain/validacao.dart` passa a ler tolerâncias desses parâmetros (em vez de constantes).
- Nova tela `/admin` com login PIN, mostrando:
  - Editar parâmetros globais.
  - Cadastro de consumo diário esperado por material.
  - Lista de alertas: consumo real fora de `[50%, 150%]` do esperado.
- Migration: schemaVersion `4`, `m.createTable(parametros)` + insert default.
- Atualizar `CHANGELOG.md` com `## 0.4.0`.
- Bump pubspec para `0.4.0+8`.

### 2. Backend Railway + dashboard web (Fase 3/4 do plano)
- Provisionar via MCP Railway (tenho ferramentas disponíveis nesta sessão):
  - serviço FastAPI + Postgres no Railway (free trial).
  - Auth real: login `hendel` / senha `admin123` (hasheada com bcrypt, JWT no cookie).
- Endpoints sugeridos:
  - `POST /contagem` (recebe JSON da sessão completa + itens + notas).
  - `GET /contagens` (lista para dashboard).
  - `GET /contagens/{id}` (detalhe).
  - `POST /auth/login` + `POST /auth/logout`.
- App ganha botão **"Compartilhar dados"** na tela Exportar → envia POST para API.
- Página admin no GitHub Pages (ou hospedada no próprio Railway): `/admin` que faz fetch na API e mostra dashboard com Chart.js (gráficos de consumo, divergências, painel por fornecedor).
- **Token/PAT:** NÃO embutir PAT no APK. Usar login do app -> backend -> auth real.
- Importante: HTTPS obrigatório, CORS liberado só para o domínio Pages.

### 3. Itens menores (pode fazer antes do backend)
- Importar cadastro mestre JSON do Streamlit (`materiais.json`) — tela `/importar_cadastro`. Substitui seed fixo.
- QR/barcode nos containers (`mobile_scanner` package) — pular busca manual.
- Pacote .zip de auditoria com Excel + PDF + fotos embutidas (hoje fotos ficam soltas).
- Aprovador para divergências grandes (segundo operador).

### 4. Polimento/bugfix conforme uso real
- Ajustar textos da tela Sobre conforme feedback do operador.
- Detectar inconsistência entre soma de NFs e recebimento com tolerância configurável.
- Suporte a aparelho compartilhado ( vários operadores mesma sessão).

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
- **Regras de foto:** desde v0.3.0 a foto é opcional. Regra em `lib/domain/validacao.dart:90-91` (apenas observação escrita exige justificativa).
- **Backup:** inclui `itens_historico` desde v0.3.3 (backup versão 2). Fotos NÃO incluídas (só caminho).

## Decisões pendentes (perguntar ao Hendel quando retomar)

1. Backup das fotos: implementar export .zip com fotos embutidas antes do backend?
2. Admin PIN padrão `0000` ou outro? Permitir alteração na primeira abertura?
3. Consumo diário esperado: virá do Streamlit (importação) ou cadastrado manualmente no admin?
4. Dashboard web: hospedar no Pages (estático, fetch da API Railway) ou dentro do próprio serviço Railway (mais simples, mas quebra GitHub Pages)?
5. Cadastro mestre: hoje o seed é fixo em `lib/data/seed.dart`. Confirmar que Streamlit pode exportar `materiais.json` no layout do item 11.1 do plano?
6. Login do backend: usar só `hendel/admin123` ou já mapear múltiplos usuários (coordenador + operador)?

## Comando rápido para retomar

Após voltar, basta ler este arquivo e perguntar:
> "Lemos o PLANO_DESENVOLVIMENTO.md — item 1 (Admin de parâmetros) ainda é o próximo?"

Que eu retomo de onde-paramos sem refazer contexto.