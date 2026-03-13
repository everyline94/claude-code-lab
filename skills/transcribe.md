# Skill: Transcrição com Whisper

Usa o modelo `whisper` da OpenAI para transcrever arquivos de áudio em texto.

## Comando base

```bash
whisper <arquivo.mp3> --model small --output_format txt --output_dir outputs/
```

## Flags explicadas

| Flag | Descrição |
|------|-----------|
| `--model small` | Modelo padrão (boa precisão, detecta idioma automaticamente) |
| `--output_format txt` | Gera apenas o arquivo `.txt` (sem `.json`, `.srt`, etc.) |
| `--output_dir outputs/` | Salva o resultado na pasta `outputs/` |
| `--language <código>` | Opcional: forçar idioma (ex: `pt`, `en`). Omitir = detecção automática |

## Modelos disponíveis

| Modelo | Velocidade | Precisão | Uso recomendado |
|--------|-----------|----------|-----------------|
| `tiny`  | Muito rápida | Baixa     | Testes rápidos |
| `base`  | Rápida       | Boa       | Testes e uso leve |
| `small` | Moderada     | Melhor    | Uso geral (padrão) |
| `medium`| Lenta        | Alta      | Qualidade profissional |
| `large` | Muito lenta  | Máxima    | Transcrição crítica |

## Exemplo completo

```bash
whisper "/tmp/meu_video.mp3" \
  --model small \
  --output_format txt \
  --output_dir "outputs/"
```

Gera: `outputs/meu_video.txt`

## Notas

- A primeira execução baixa o modelo (alguns centenas de MB)
- Para inglês: `--language en`
- Para detecção automática de idioma: omitir `--language`
- O Whisper aceita `.mp3`, `.mp4`, `.wav`, `.m4a`, entre outros
