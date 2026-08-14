# Contagens publicadas

Esta pasta guarda os resultados de contagem exibidos em
`downloads/contagens.html`, publicada pelo GitHub Pages.

## Fonte dos dados

A pagina tenta ler primeiro a API configurada em `config.js`:

```js
window.CONTAGENS_API_URL =
  "https://backend-production-3a35.up.railway.app/api/public/contagens/";
```

Se a API estiver fora do ar ou vazia, a pagina usa `manifest.json` como
fallback manual.

## Como publicar uma contagem

Este fluxo manual continua disponivel para anexar Excel, ZIP e PDF na pagina.
Depois de exportar os arquivos no app Android, rode o script abaixo no
computador de desenvolvimento.

```bash
python3 scripts/publicar_contagem.py \
  --titulo "Contagem 2026-08-13 - Joao Silva" \
  --operador "Joao Silva" \
  --matricula "12345" \
  --data "2026-08-13" \
  --turno "Manha" \
  --total-materiais 29 \
  --alertas 0 \
  --bloqueios 0 \
  --excel "/caminho/contagem.xlsx" \
  --zip "/caminho/auditoria.zip" \
  --pdf "/caminho/relatorio.pdf"
```

O script copia os arquivos para uma subpasta em `downloads/contagens/` e
atualiza `manifest.json`.

Depois publique no GitHub:

```bash
git add downloads/contagens
git commit -m "Publica resultado da contagem 2026-08-13"
git push origin main
```

O workflow do GitHub Pages roda automaticamente porque houve alteracao dentro
de `downloads/`.

## Formato do manifest

```json
{
  "atualizadoEm": "2026-08-13",
  "schema": 2,
  "contagens": [
    {
      "titulo": "Contagem 2026-08-13 - Joao Silva",
      "operador": "Joao Silva",
      "matricula": "12345",
      "data": "2026-08-13",
      "turno": "Manha",
      "totalMateriais": 29,
      "alertas": 0,
      "bloqueios": 0,
      "arquivos": {
        "excel": "contagens/2026-08-13_joao-silva/contagem.xlsx",
        "zip": "contagens/2026-08-13_joao-silva/auditoria.zip",
        "pdf": "contagens/2026-08-13_joao-silva/relatorio.pdf"
      },
      "observacao": "Resultado para importacao e auditoria"
    }
  ]
}
```

Observacao: GitHub Pages e publico. Esta pagina facilita o acesso aos arquivos,
mas nao e uma area privada com senha real.
