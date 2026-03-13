# TASKS — Projeto 01: Transcriber

## Plano

**Objetivo:** Receber uma URL de vídeo (YouTube, TikTok, Instagram), baixar o áudio e devolver uma transcrição em `.txt`.

**Ferramentas:** `yt-dlp`, `ffmpeg`, `whisper`, `Claude`

**Fluxo:**
```
URL → download → transcrição bruta → limpeza com Claude → texto final
```

**Estrutura do projeto:**
```
Projeto 01 - Transcriber/
├── CLAUDE.md              ← contexto do projeto para o Claude Code
├── TASKS.md               ← este arquivo (memória do projeto)
├── orchestrator.md        ← pipeline com sub-agentes para uso no Claude Code
├── skills/
│   ├── download.md        ← skill: baixar áudio com yt-dlp
│   ├── transcribe.md      ← skill: transcrever com Whisper
│   └── clean.md           ← skill: limpar transcrição com Claude
├── transcribe.sh          ← script direto para uso no terminal
└── outputs/
    ├── <nome>_bruto.txt   ← saída bruta do Whisper
    └── <nome>_limpo.txt   ← versão limpa pelo Claude
```

---

## Tarefas de criação inicial

| # | Tarefa                        | Status     |
|---|-------------------------------|------------|
| 1 | Criar estrutura de pastas     | concluído  |
| 2 | Criar TASKS.md                | concluído  |
| 3 | Criar CLAUDE.md               | concluído  |
| 4 | Criar skills/download.md      | concluído  |
| 5 | Criar skills/transcribe.md    | concluído  |
| 6 | Criar transcribe.sh           | concluído  |

---

## Tarefas de instalação de dependências

| # | Tarefa                        | Versão         | Status     |
|---|-------------------------------|----------------|------------|
| 7 | Instalar yt-dlp               | 2026.03.03     | concluído  |
| 8 | Instalar ffmpeg               | 8.0.1          | concluído  |
| 9 | Instalar openai-whisper       | 20240930       | concluído  |

> Whisper instalado via `pip3` (Python 3.9 do sistema). Binário em `~/Library/Python/3.9/bin/`.
> O `transcribe.sh` usa `python3 -m whisper` como fallback quando `whisper` não está no PATH.

---

## Tarefas de ajuste de qualidade

| #  | Tarefa                                              | Status     |
|----|-----------------------------------------------------|------------|
| 10 | Remover `--language pt` fixo (detecção automática) | concluído  |
| 11 | Trocar modelo `base` → `small`                     | concluído  |
| 12 | Atualizar skills/transcribe.md                     | concluído  |
| 13 | Atualizar CLAUDE.md com novas convenções           | concluído  |

---

## Tarefas de expansão do fluxo

| #  | Tarefa                                              | Status     |
|----|-----------------------------------------------------|------------|
| 14 | Criar skills/clean.md                              | concluído  |
| 15 | Atualizar CLAUDE.md com fluxo completo             | concluído  |
| 16 | Atualizar TASKS.md                                 | concluído  |

---

## Tarefas de refatoração para sub-agentes (Sessão 3)

| #  | Tarefa                                                        | Status     |
|----|---------------------------------------------------------------|------------|
| 23 | Criar orchestrator.md com 3 sub-agentes                      | concluído  |
| 24 | Atualizar CLAUDE.md com dois modos de uso                    | concluído  |
| 25 | Atualizar TASKS.md com orchestrator na estrutura             | concluído  |

---

## Tarefas de melhoria geral (Sessão 2)

| #  | Tarefa                                                        | Status     |
|----|---------------------------------------------------------------|------------|
| 17 | CLAUDE.md — seção "Próximos passos"                          | concluído  |
| 18 | TASKS.md — remover linha "Ferramentas" duplicada             | concluído  |
| 19 | skills/download.md — `--no-playlist` no comando base         | concluído  |
| 20 | skills/clean.md — idioma dinâmico (detecção automática)      | concluído  |
| 21 | transcribe.sh — renomear saída para `_bruto.txt` automático  | concluído  |
| 22 | transcribe.sh — suporte a arquivo local (pular download)     | concluído  |

---

## Histórico de sessões

### Sessão 1 — 2026-03-12
- Projeto criado do zero
- Estrutura de pastas definida e aprovada
- Caminho: `~/Documents/Projetos Claude Code/Projeto 01 - Transcriber/`
- Todas as dependências instaladas: yt-dlp 2026.03.03, ffmpeg 8.0.1, whisper 20240930
- `transcribe.sh` ajustado para detectar whisper fora do PATH automaticamente
- Teste bem-sucedido com vídeo TikTok (inglês transcrito com detecção automática)
- Modelo atualizado de `base` → `small`; idioma agora detectado automaticamente
- skill `clean.md` criada com prompt de limpeza
- Teste completo do fluxo bruto → limpo com vídeo TikTok

### Sessão 3 — 2026-03-12
- `orchestrator.md` criado: pipeline com 3 sub-agentes (Download, Transcrição, Limpeza)
- `CLAUDE.md` atualizado: dois modos de uso (terminal vs Claude Code), estrutura com orchestrator
- `TASKS.md` atualizado: estrutura do projeto reflete `orchestrator.md`
- Item "Múltiplos agentes" em "Próximos passos" marcado como implementado

### Sessão 2 — 2026-03-12
- `transcribe.sh` agora salva automaticamente como `_bruto.txt` (sem renomear manualmente)
- `transcribe.sh` aceita arquivo local como argumento, pulando o download
- `skills/clean.md` com idioma dinâmico — detecta o idioma da transcrição automaticamente
- `skills/download.md` com `--no-playlist` no comando base
- `CLAUDE.md` atualizado com fluxo simplificado e seção "Próximos passos"
- Teste de download confirmado (YouTube — Rick Astley): yt-dlp OK, nomeação `_bruto.txt` OK, limpeza de /tmp OK
