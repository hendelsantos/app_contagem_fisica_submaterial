# Contagens publicadas

Coloque os arquivos de contagem nesta pasta e cadastre cada item no
`manifest.json`.

Exemplo:

```json
{
  "atualizadoEm": "2026-08-13",
  "contagens": [
    {
      "titulo": "Contagem 13/08/2026 - Joao Silva",
      "operador": "Joao Silva",
      "matricula": "12345",
      "data": "2026-08-13",
      "tipo": "Excel",
      "arquivo": "contagens/contagem_2026-08-13_joao.xlsx",
      "observacao": "Arquivo para importacao"
    }
  ]
}
```

Depois de subir para o GitHub Pages, a pagina `contagens.html` mostra o botao
de download e gera o QR code do arquivo automaticamente.
