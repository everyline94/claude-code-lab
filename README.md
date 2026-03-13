# Claude Code Lab

Repositório de projetos construídos com o **Claude Code** — a CLI oficial da Anthropic que transforma o terminal em um agente de engenharia de software com acesso direto ao sistema de arquivos, shell e ferramentas externas.

---

## Projetos

| # | Projeto | Descrição |
|---|---------|-----------|
| 01 | [Transcriber](.) | Recebe uma URL de vídeo (YouTube, TikTok, Instagram), baixa o áudio e devolve uma transcrição em `.txt` |

---

## Stack e ferramentas

| Ferramenta | Uso |
|------------|-----|
| [yt-dlp](https://github.com/yt-dlp/yt-dlp) | Download de áudio a partir de URLs de vídeo |
| [ffmpeg](https://ffmpeg.org) | Conversão e processamento de áudio |
| [OpenAI Whisper](https://github.com/openai/whisper) | Transcrição de fala para texto (modelo `small`) |
| Python 3 | Runtime do Whisper |
| Bash | Scripts de automação (`transcribe.sh`) |
| Claude API | Limpeza e coesão das transcrições brutas |

---

## Estrutura do repositório

```
claude-code-lab/
└── Projeto 01 - Transcriber/
    ├── CLAUDE.md              ← contexto do projeto para o Claude Code
    ├── TASKS.md               ← memória e histórico do projeto
    ├── orchestrator.md        ← pipeline com sub-agentes (uso no Claude Code)
    ├── transcribe.sh          ← script direto para uso no terminal
    ├── skills/
    │   ├── download.md        ← skill: baixar áudio com yt-dlp
    │   ├── transcribe.md      ← skill: transcrever com Whisper
    │   └── clean.md           ← skill: limpar transcrição com Claude
    └── outputs/               ← transcrições geradas (ignoradas pelo .gitignore)
```
