# PDF Extractor

Pipeline que combina uma descrição de aula em texto com um PDF de mapa mental e gera um documento de estudo estruturado em Markdown, pronto para colar no Google Docs.

---

## Como usar

Cole o prompt abaixo no Antigravity, substituindo a descrição e anexando o PDF:

```
Vamos testar o fluxo completo.

Descrição da aula (cole o texto abaixo):
[cole aqui a descrição completa da aula]

O PDF do mapa mental está em anexo.

Siga o fluxo do CLAUDE.md:
- Agente 1: salva a descrição como inputs/<nome>_descricao.txt
            e extrai o texto do PDF como inputs/<nome>_mapa.txt
- Agente 2: aplica a skill combine.md e gera outputs/<nome>_estudo.md

Ao final, me mostra o conteúdo completo do arquivo gerado.
```

---

## Fluxo do pipeline

```
Descrição da aula (colada no chat)
         +
PDF do mapa mental (arrastado pro chat)
         ↓
[Agente 1: salva _descricao.txt + extrai _mapa.txt com pdfplumber]
         ↓
[Agente 2: aplica combine.md]
         ↓
outputs/<nome>_estudo.md
```

---

## O que o documento de estudo contém

| Seção | Conteúdo |
|-------|----------|
| Resumo Executivo | 3-4 linhas com o essencial da aula |
| Mapa Lógico | Progressão da aula em formato de fluxo |
| Conceitos-Chave | Cada conceito com definição + contexto de uso |
| Aplicações Práticas | O que fazer com o conteúdo |
| Frases-Chave | Citações marcantes da aula |
| Glossário | Termos técnicos do contexto da aula |

---

## Estrutura do projeto

```
Projeto 02 - PDF Extractor/
├── CLAUDE.md              ← contexto do projeto para o Claude Code
├── TASKS.md               ← memória e histórico do projeto
├── README.md              ← este arquivo
├── skills/
│   └── combine.md         ← skill: combinar descrição + mapa mental
├── inputs/                ← arquivos de entrada (ignorados pelo Git)
│   ├── <nome>_descricao.txt
│   └── <nome>_mapa.txt
└── outputs/               ← documentos de estudo gerados (ignorados pelo Git)
    └── <nome>_estudo.md
```

---

## Requisitos e instalação

```bash
pip install pdfplumber      # extração de texto de PDFs
```

### Stack completa

| Ferramenta | Uso |
|------------|-----|
| [pdfplumber](https://github.com/jsvine/pdfplumber) | Extração de texto de arquivos PDF |
| Python 3 | Runtime do pdfplumber |
| Claude (API) | Combinação e estruturação do documento de estudo |
