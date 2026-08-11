# AGENTS.md — Contagem Física HMB (Flutter)

Comandos padrão para trabalhar neste projeto.

## Ambiente

- Flutter 3.24 (Dart 3.5)
- Projeto em `contagem_fisica/` (este diretório).
- Banco local: SQLite via Drift (`lib/data/database.dart`).
- Stack: Material 3 + Riverpod 2 + go_router 14.

## Comandos comuns

```bash
# instalar deps
flutter pub get

# regenerar código do Drift (sempre após editar data/tables.dart ou database.dart)
dart run build_runner build --delete-conflicting-outputs

# rodar no dispositivo/emulador
flutter run

# testes das regras anti-erro
flutter test

# análise estática (treat warnings as needed)
flutter analyze

# APK debug
flutter build apk --debug

# APK release (para instalar no aparelho do operador)
flutter build apk --release
```

## Convenções

- Sem comentários no código, salvo exigência explícita.
- Modelos Drift: `@DataClassName('...')` em `data/tables.dart` — evitar colisão
  com classes do Flutter (ex.: `Material`).
- Regras anti-erro ficam em `lib/domain/validacao.dart` — não duplicar lógica
  nas telas.
- Telas em `lib/ui/` consomem Riverpod providers de `lib/providers/`.
- Após mudar qualquer `*.dart` com `part '*.g.dart'`, reexecute o build_runner.

## Especificação

`../PLANO_APP_FLUTTER_CONTAGEM.md` — especificação funcional completa.
`README.md` — resumo das decisões e do fluxo do app.