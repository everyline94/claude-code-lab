# Skill: Limpeza de Transcrição com Claude

Usa o Claude para transformar uma transcrição bruta do Whisper em um texto limpo, coeso e legível.

## Quando usar

Após gerar o arquivo bruto com `transcribe.sh`. O Whisper transcreve fielmente tudo que foi dito — incluindo vícios de linguagem, repetições, saudações e ruídos de conversa. Esta skill usa o Claude para filtrar e organizar esse conteúdo.

## Fluxo

```
outputs/<nome>.txt  →  [Claude + prompt abaixo]  →  outputs/<nome>_limpo.txt
```

O arquivo bruto original deve ser **preservado** e renomeado para `outputs/<nome>_bruto.txt` antes da limpeza.

## Prompt base

Envie ao Claude o conteúdo do arquivo `.txt` junto com o seguinte prompt:

---

```
Você receberá uma transcrição bruta de vídeo gerada pelo Whisper.
Detecte automaticamente o idioma do texto e produza o resultado no mesmo idioma.
Sua tarefa é transformá-la em um texto limpo e coeso.

REMOVA:
- Saudações e despedidas
- Comentários de logística ("vou compartilhar a tela", pausas, etc.)
- Repetições e redundâncias — mantenha apenas a versão mais completa
- Confirmações sem conteúdo ("certo", "sim sim", "exato", quando isoladas)

PRESERVE:
- Todo conteúdo informativo e técnico
- Exemplos, analogias e casos práticos
- A ordem cronológica dos tópicos
- Termos técnicos exatamente como foram usados

FORMATO DE SAÍDA:
- Texto corrido, sem marcadores de fala
- Parágrafos separados por tema
- Sem títulos criados por você
- Idioma: mesmo idioma da transcrição recebida (detectado automaticamente)

Ao final, adicione:
---
[RESUMO DE CORTES: X% do texto original removido — principalmente [tipos de conteúdo cortado] | Idioma detectado: <idioma>]
```

---

## Como executar

1. Renomeie o bruto:
```bash
mv "outputs/<nome>.txt" "outputs/<nome>_bruto.txt"
```

2. Abra o Claude Code neste projeto e envie:
```
Leia outputs/<nome>_bruto.txt e aplique a skill skills/clean.md.
Salve o resultado em outputs/<nome>_limpo.txt.
```

## Convenção de nomes

| Arquivo | Descrição |
|---------|-----------|
| `outputs/<nome>_bruto.txt` | Transcrição original do Whisper, sem alterações |
| `outputs/<nome>_limpo.txt` | Versão limpa e coesa gerada pelo Claude |

## Notas

- O arquivo bruto nunca deve ser sobrescrito — serve como referência e auditoria
- O idioma é detectado automaticamente — não é necessário ajustar o prompt por idioma
- O resumo de cortes ao final ajuda a avaliar a qualidade da transcrição original
