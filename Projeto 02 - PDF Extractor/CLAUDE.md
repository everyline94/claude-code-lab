# Projeto 02 - PDF Extractor

## O que faz

Recebe dois inputs por aula — uma descrição em texto e um PDF com mapa mental — combina os dois e gera um documento de estudo estruturado em Markdown, pronto para colar no Google Docs.

## Dependências

- Python 3
- pdfplumber (instalado no venv: `.venv/`)

## Fluxo de uso

### Agente 1: Processar inputs

1. O usuário cola a descrição da aula no chat
   → Claude salva como `inputs/<nome>_descricao.txt`

2. O usuário fornece o PDF do mapa mental
   → Claude extrai o texto com pdfplumber → salva como `inputs/<nome>_mapa.txt`

**Comando para extrair texto do PDF:**
```bash
.venv/bin/python3 -c "import pdfplumber; pdf=pdfplumber.open('<arquivo.pdf>'); print('\n'.join(p.extract_text() or '' for p in pdf.pages))"
```

### Agente 2: Gerar documento de estudo

1. Claude lê `inputs/<nome>_descricao.txt` e `inputs/<nome>_mapa.txt`
2. Aplica as instruções de `skills/combine.md`
3. Gera `outputs/<nome>_estudo.md`

## Convenções

- `<nome>` é derivado do título da aula em snake_case (ex: `mvps`, `growth_hacking`)
- Inputs sempre preservados em `inputs/`
- Output sempre em português
- Markdown limpo: `#`, `##`, `-`, `>`, `**bold**` — sem formatação que quebre no Google Docs
- Arquivos de saída seguem o padrão: `<nome>_estudo.md`

## Estrutura do projeto

```
Projeto 02 - PDF Extractor/
├── CLAUDE.md          ← este arquivo
├── TASKS.md           ← memória do projeto
├── .gitignore
├── .venv/             ← virtual environment (pdfplumber)
├── skills/
│   └── combine.md     ← skill para gerar documento de estudo
├── inputs/            ← arquivos _descricao.txt e _mapa.txt
└── outputs/           ← arquivos _estudo.md
```
