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