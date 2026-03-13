# Transcriber

Pipeline de transcrição de vídeos usando **yt-dlp**, **Whisper** e **Claude**. Recebe uma URL (YouTube, TikTok, Instagram) ou arquivo local de áudio/vídeo, transcreve com Whisper e processa o resultado com Claude em dois modos.

---

## Modos de uso

| Modo | Descrição | Saída |
|------|-----------|-------|
| **(1) Transcrição limpa** | Texto corrido, coeso, sem ruído | `outputs/<nome>_limpo.txt` |
| **(2) Anotações de aula** | Markdown estruturado com títulos, bullets, takeaways e glossário | `outputs/<nome>_anotacoes.md` |

---

## Como usar

### Via Claude Code (recomendado)

Cole um dos prompts abaixo diretamente no Claude Code, substituindo `<URL>` pela URL do vídeo ou caminho do arquivo local.

**Modo 1 — Transcrição limpa:**

```
Execute o pipeline de transcrição limpa para <URL>:

1. Agente Download: use skills/download.md para baixar o áudio de <URL>
   → confirme o caminho do .mp3 antes de continuar

2. Agente Transcrição: use skills/transcribe.md para transcrever o .mp3
   → salve em outputs/<título>_bruto.txt e confirme antes de continuar

3. Agente Limpeza: use skills/clean.md para limpar outputs/<título>_bruto.txt
   → salve o resultado em outputs/<título>_limpo.txt

Se qualquer etapa falhar, pare e informe em qual agente ocorreu o erro.
```

**Modo 2 — Anotações de aula:**

```
Execute o pipeline de anotações de aula para <URL>:

1. Agente Download: use skills/download.md para baixar o áudio de <URL>
   → confirme o caminho do .mp3 antes de continuar

2. Agente Transcrição: use skills/transcribe.md para transcrever o .mp3
   → salve em outputs/<título>_bruto.txt e confirme antes de continuar

3. Agente Anotações: use skills/annotate.md para anotar outputs/<título>_bruto.txt
   → salve o resultado em outputs/<título>_anotacoes.md

Se qualquer etapa falhar, pare e informe em qual agente ocorreu o erro.
```

### Via terminal (script direto)

```bash
chmod +x transcribe.sh        # apenas na primeira vez
./transcribe.sh <URL>          # transcrever de URL
./transcribe.sh <arquivo.mp3>  # transcrever de arquivo local
```

Gera `outputs/<nome>_bruto.txt`. Depois aplique o Modo 1 ou 2 no Claude Code.

---

## Fluxo do pipeline

```
URL / arquivo  →  [Agente 1: download]  →  .mp3  →  [Agente 2: transcrição]  →  _bruto.txt
                                                                                      ↓
                                                                            ┌─────────┴─────────┐
                                                                            ↓                   ↓
                                                                 [Modo 1: clean.md]   [Modo 2: annotate.md]
                                                                            ↓                   ↓
                                                                      _limpo.txt          _anotacoes.md
```

---

## Estrutura do projeto

```
Projeto 01 - Transcriber/
├── CLAUDE.md              ← contexto do projeto para o Claude Code
├── TASKS.md               ← memória e histórico do projeto
├── README.md              ← este arquivo
├── orchestrator.md        ← pipeline com sub-agentes (uso no Claude Code)
├── transcribe.sh          ← script direto para uso no terminal
├── skills/
│   ├── download.md        ← skill: baixar áudio com yt-dlp
│   ├── transcribe.md      ← skill: transcrever com Whisper
│   ├── clean.md           ← skill: limpeza com Claude (Modo 1)
│   └── annotate.md        ← skill: anotações de aula com Claude (Modo 2)
└── outputs/               ← transcrições geradas
    ├── <nome>_bruto.txt   ← saída bruta do Whisper (preservada sempre)
    ├── <nome>_limpo.txt   ← texto limpo (Modo 1)
    └── <nome>_anotacoes.md ← anotações estruturadas (Modo 2)
```

---

## Modelos Whisper disponíveis

| Modelo | Parâmetros | VRAM | Velocidade | Quando usar |
|--------|-----------|------|------------|-------------|
| `tiny` | 39M | ~1 GB | Muito rápida | Testes rápidos, áudio claro em inglês |
| `base` | 74M | ~1 GB | Rápida | Áudio claro, quando velocidade importa |
| `small` | 244M | ~2 GB | Moderada | **Padrão do projeto** — bom equilíbrio entre precisão e velocidade |
| `medium` | 769M | ~5 GB | Lenta | Áudio com ruído ou sotaques fortes |
| `large` | 1550M | ~10 GB | Muito lenta | Máxima precisão, quando tempo não importa |

O modelo padrão é `small`. Para trocar, passe `--model <nome>` ao Whisper.

---

## Requisitos e instalação

### Dependências

```bash
brew install yt-dlp       # download de áudio de URLs
brew install ffmpeg        # conversão e processamento de áudio
pip3 install openai-whisper # transcrição de fala para texto
```

### Nota sobre o PATH do Whisper

O `whisper` pode ser instalado fora do PATH (ex: `~/Library/Python/3.9/bin/`). O `transcribe.sh` detecta isso automaticamente e usa `python3 -m whisper` como fallback.

Para adicionar ao PATH permanentemente:

```bash
export PATH="$HOME/Library/Python/3.9/bin:$PATH"  # adicionar ao ~/.zshrc
```

### Stack completa

| Ferramenta | Uso |
|------------|-----|
| [yt-dlp](https://github.com/yt-dlp/yt-dlp) | Download de áudio a partir de URLs |
| [ffmpeg](https://ffmpeg.org) | Conversão e processamento de áudio |
| [OpenAI Whisper](https://github.com/openai/whisper) | Transcrição de fala para texto |
| Python 3 | Runtime do Whisper |
| Bash | Script de automação (`transcribe.sh`) |
| Claude (API) | Limpeza e anotações das transcrições |
