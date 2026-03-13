# TASKS — Projeto 02: PDF Extractor

## Objetivo geral

Receber descrição de aula (texto) + PDF de mapa mental → combinar → gerar documento de estudo em Markdown.

## Estrutura

```
inputs/   → _descricao.txt + _mapa.txt
skills/   → combine.md (prompt de combinação)
outputs/  → _estudo.md (documento final)
```

## Dependências

- Python 3.9.6
- pdfplumber 0.11.8 (venv em `.venv/`)

## Tarefas

| # | Tarefa | Status |
|---|--------|--------|
| 1 | Criar estrutura de pastas (inputs/, outputs/, skills/) | Concluído |
| 2 | Instalar pdfplumber (via venv) | Concluído |
| 3 | Criar CLAUDE.md | Concluído |
| 4 | Criar skills/combine.md | Concluído |
| 5 | Criar TASKS.md | Concluído |
| 6 | Criar .gitignore | Concluído |
| 7 | Teste end-to-end com exemplo real | Pendente |

## Histórico de sessões

### Sessão 1 — 2026-03-13: Setup inicial

- Criada estrutura de pastas: inputs/, outputs/, skills/
- Instalado pdfplumber 0.11.8 via venv (.venv/)
- Criado CLAUDE.md com contexto, fluxo e convenções
- Criado skills/combine.md com prompt completo para gerar documento de estudo
- Criado .gitignore (ignora inputs, outputs, venv, .DS_Store)
- Criado TASKS.md com tarefas e histórico
