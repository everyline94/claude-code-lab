# Skill: Download de Áudio com yt-dlp

Usa `yt-dlp` para baixar apenas o áudio de uma URL de vídeo.

## Comando base

```bash
yt-dlp --extract-audio --audio-format mp3 --no-playlist -o "/tmp/%(title)s.%(ext)s" <URL>
```

## Flags explicadas

| Flag | Descrição |
|------|-----------|
| `--extract-audio` | Extrai somente o áudio (sem vídeo) |
| `--audio-format mp3` | Converte para MP3 (requer ffmpeg) |
| `-o "/tmp/%(title)s.%(ext)s"` | Salva em `/tmp/` com o título do vídeo como nome |
| `--no-playlist` | Baixa apenas o vídeo, não a playlist inteira |

## Exemplo completo

```bash
yt-dlp \
  --extract-audio \
  --audio-format mp3 \
  --no-playlist \
  -o "/tmp/%(title)s.%(ext)s" \
  "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
```

## Plataformas suportadas

- YouTube
- TikTok
- Instagram (Reels e posts com vídeo)
- E centenas de outros sites (ver `yt-dlp --list-extractors`)

## Notas

- O `ffmpeg` precisa estar instalado para a conversão para MP3
- O nome do arquivo de saída pode conter caracteres especiais — o `transcribe.sh` lida com isso
- Para verificar a URL antes de baixar: `yt-dlp --get-title <URL>`
