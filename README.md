# App Contagem Física — Submaterial (HMB)

App Android Flutter offline para contagem física de materiais anti-erro, com
exportação de Excel compatível com o Streamlit HMB.

## Estrutura do repositório

| Caminho | Descrição |
|---|---|
| [`PLANO_APP_FLUTTER_CONTAGEM.md`](./PLANO_APP_FLUTTER_CONTAGEM.md) | Especificação funcional completa (objetivos, regras, roadmap) |
| [`contagem_fisica/`](./contagem_fisica/) | Projeto Flutter (MVP Fase 1) |
| [`contagem_fisica/README.md`](./contagem_fisica/README.md) | Documentação do app Flutter (stack, fluxo, build) |
| [`contagem_fisica/AGENTS.md`](./contagem_fisica/AGENTS.md) | Comandos padrão para desenvolver no projeto |
| [`downloads/index.html`](./downloads/index.html) | Página pública com QR code para instalar o APK |
| [`.github/workflows/pages.yml`](./.github/workflows/pages.yml) | Publica a página `downloads/` no GitHub Pages |

## MVP (Fase 1) — status

- ✅ Cadastro local (Drift/SQLite) com 29 materiais + 5 fornecedores (seed)
- ✅ Tela de Setup (operador + matrícula + período)
- ✅ Home com cards por fornecedor (contadores: total/contados/pendentes/alertas/bloqueios)
- ✅ Lista por fornecedor + contagem guiada por material
- ✅ Regras anti-erro (negativo, NF faltante, soma de NFs, aumento sem recebimento)
- ✅ Tolerância `max(2% do estoque anterior, 1 Kg/L)`
- ✅ Divergência liberada apenas com justificativa + foto
- ✅ Foto obrigatória apenas em divergências
- ✅ Continuidade: estoque válido vira referência da próxima contagem
- ✅ Resumo final bloqueando export enquanto houver pendente/bloqueado
- ✅ Gerador de Excel compatível com `core/importers.py::importar_stock_operador`
- ✅ Aba extra `Auditoria App` no Excel
- ✅ PDF de auditoria
- ✅ APK debug gerado

## Próximas fases

- **Fase 2** — Auditoria reforçada (dupla contagem, aprovador, pacote .zip)
- **Fase 3** — Sincronização com Streamlit (importar JSON exportado)
- **Fase 4** — API direta (FastAPI + fila offline)

## Como rodar

```bash
cd contagem_fisica
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run                 # ou flutter build apk --release
flutter test                # regras anti-erro
```

Mais detalhes em [`contagem_fisica/README.md`](./contagem_fisica/README.md).

## Distribuir APK via QR code

Há uma página pública em `downloads/index.html` (publicada no GitHub Pages)
com um QR code que aponta sempre para a **versão mais recente** do APK
hospedada em **GitHub Releases**. O operador escaneia com o celular e baixa
o app — funciona offline depois de baixado.

### 1) Habilitar GitHub Pages (uma única vez)

- Repo no GitHub: **Settings → Pages**
- Em **Build and deployment → Source**: escolha **GitHub Actions**
  (o workflow `.github/workflows/pages.yml` cuida do resto).
- A URL final será algo como
  `https://hendelsantos.github.io/app_contagem_fisica_submaterial/`.

### 2) Gerar e publicar o APK

```bash
cd contagem_fisica
flutter build apk --release                       # gera build/app/outputs/flutter-apk/app-release.apk
# renomeie para o nome esperado pela página:
cp build/app/outputs/flutter-apk/app-release.apk ../app-release.apk
```

### 3) Criar a Release no GitHub

- Repo: **Releases → Draft a new release**
- **Choose a tag**: `v0.1.0` (ou a versão que quiser)
- **Attach binaries**: arraste o arquivo `app-release.apk`
- **Publish release**

Pronto — ao publicar, o QR code da página automaticamente aponta para a nova
versão (URL `.../releases/latest/download/app-release.apk`).

### 4) Atualizar no futuro

- Suba código novo com `git push`
- Rode `flutter build apk --release` para gerar nova versão
- Crie nova Release (`v0.2.0`, etc.) e anexe o APK
- A página e o QR code **continuam os mesmos** — sempre apontam para "latest".

### Console / alternative API

A página usa `api.qrserver.com` para gerar o QR code e `api.github.com`
para mostrar a tag da versão atual. Ambos são serviços públicos gratuitos.
Se a rede da fábrica bloquear `api.qrserver.com`, dá pra trocar por uma
lib JS embutida ou outro serviço de QR (ver comentário no `index.html`).