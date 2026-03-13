#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# transcribe.sh — Transcreve áudio de uma URL ou arquivo local com Whisper
# Uso: ./transcribe.sh <URL>
#      ./transcribe.sh <arquivo.mp3>
# ---------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUTS_DIR="$SCRIPT_DIR/outputs"

# --- Validação de argumento -------------------------------------------------

if [[ $# -lt 1 ]]; then
  echo "Uso: $0 <URL ou arquivo>"
  echo "Exemplos:"
  echo "  $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  echo "  $0 /caminho/para/audio.mp3"
  exit 1
fi

INPUT="$1"

# --- Detecta modo: arquivo local ou URL ------------------------------------

if [[ -f "$INPUT" ]]; then
  AUDIO_FILE="$INPUT"
  IS_LOCAL=true
  echo "Arquivo local detectado: $AUDIO_FILE"
else
  IS_LOCAL=false
fi

# --- Verificação de dependências -------------------------------------------

if [[ "$IS_LOCAL" == false ]]; then
  for cmd in yt-dlp ffmpeg; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Erro: '$cmd' não encontrado. Veja as instruções de instalação em CLAUDE.md."
      exit 1
    fi
  done
fi

# Whisper pode estar fora do PATH (instalado via pip no diretório do usuário)
if command -v whisper &>/dev/null; then
  WHISPER_CMD="whisper"
elif python3 -c "import whisper" &>/dev/null 2>&1; then
  WHISPER_CMD="python3 -m whisper"
else
  echo "Erro: 'whisper' não encontrado. Execute: pip3 install openai-whisper"
  exit 1
fi

# --- Download do áudio (apenas para URLs) -----------------------------------

if [[ "$IS_LOCAL" == false ]]; then
  echo "Baixando áudio de: $INPUT"

  AUDIO_FILE=$(yt-dlp \
    --extract-audio \
    --audio-format mp3 \
    --no-playlist \
    --print after_move:filepath \
    -o "/tmp/%(title)s.%(ext)s" \
    "$INPUT")

  if [[ ! -f "$AUDIO_FILE" ]]; then
    echo "Erro: arquivo de áudio não encontrado após o download."
    exit 1
  fi

  echo "Áudio salvo em: $AUDIO_FILE"
fi

# --- Transcrição ------------------------------------------------------------

echo "Transcrevendo..."

$WHISPER_CMD "$AUDIO_FILE" \
  --model small \
  --output_format txt \
  --output_dir "$OUTPUTS_DIR"

# --- Renomear para _bruto.txt -----------------------------------------------

BASENAME=$(basename "$AUDIO_FILE" .mp3)
OUTPUT_FILE="$OUTPUTS_DIR/${BASENAME}.txt"
BRUTO_FILE="$OUTPUTS_DIR/${BASENAME}_bruto.txt"

if [[ -f "$OUTPUT_FILE" ]]; then
  mv "$OUTPUT_FILE" "$BRUTO_FILE"
fi

# --- Limpeza do áudio temporário (apenas para downloads) -------------------

if [[ "$IS_LOCAL" == false ]]; then
  rm -f "$AUDIO_FILE"
fi

# --- Resultado --------------------------------------------------------------

echo ""
echo "Transcrição concluída: $BRUTO_FILE"
echo "Próximo passo: aplique skills/clean.md para gerar ${BASENAME}_limpo.txt"
