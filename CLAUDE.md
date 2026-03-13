# Transcriber

Recebe uma URL de vídeo (YouTube, TikTok, Instagram), baixa o áudio e devolve uma transcrição em `.txt`.

## Dependências

Instale antes de usar:

```bash
brew install yt-dlp
brew install ffmpeg
pip3 install openai-whisper
```

> **Nota:** O `whisper` pode ser instalado fora do PATH (`~/Library/Python/3.9/bin/`).
> O `transcribe.sh` detecta isso automaticamente e usa `python3 -m whisper` como fallback.
> Para adicionar ao PATH permanentemente: `export PATH="$HOME/Library/Python/3.9/bin:$PATH"` no seu `~/.zshrc`.

## Como usar

### Modo terminal (script)

```bash
chmod +x transcribe.sh        # apenas na primeira vez
./transcribe.sh <URL>          # transcrever de URL
./transcribe.sh <arquivo.mp3>  # transcrever de arquivo local
```

Gera `outputs/<título>_bruto.txt`. Depois aplique `skills/clean.md` no Claude Code para gerar `_limpo.txt`.

### Modo Claude Code (orquestrador)

Use `orchestrator.md` para acionar o pipeline completo com controle por etapa e reexecução granular. Ver instruções em [orchestrator.md](orchestrator.md).

## Fluxo completo

```
URL  →  [Agente 1: download.md]  →  .mp3  →  [Agente 2: transcribe.md]  →  _bruto.txt
                                                                                  ↓
                                                                    [Agente 3: clean.md]
                                                                                  ↓
                                                                            _limpo.txt
```

## Estrutura

```
Projeto 01 - Transcriber/
├── CLAUDE.md              ← este arquivo
├── TASKS.md               ← memória e progresso do projeto
├── orchestrator.md        ← pipeline com sub-agentes (uso no Claude Code)
├── skills/
│   ├── download.md        ← skill: yt-dlp
│   ├── transcribe.md      ← skill: whisper
│   └── clean.md           ← skill: limpeza com Claude
├── transcribe.sh          ← script direto para uso no terminal
└── outputs/               ← transcrições geradas
    ├── <nome>_bruto.txt   ← saída bruta do Whisper (preservar sempre)
    └── <nome>_limpo.txt   ← versão limpa pelo Claude
```

## Convenções

- Áudio temporário salvo em `/tmp/` e removido após a transcrição
- Bruto sempre preservado em `outputs/<nome>_bruto.txt`
- Limpo sempre salvo em `outputs/<nome>_limpo.txt`
- Idioma: detecção automática (sem `--language`); use `--language pt` ou `--language en` para forçar
- Modelo Whisper padrão: `small` (melhor precisão, detecta idioma automaticamente)

## Próximos passos

Melhorias planejadas para versões futuras:

- **Suporte a arquivos locais** ✓ implementado — passar caminho de arquivo ao `transcribe.sh` em vez de URL
- **Múltiplos agentes independentes** ✓ implementado — ver `orchestrator.md`
- **Idioma dinâmico na clean.md** ✓ implementado — detecção automática do idioma no prompt de limpeza
- **Integração com Notion** — salvar transcrições limpas automaticamente em uma base de dados Notion via API
