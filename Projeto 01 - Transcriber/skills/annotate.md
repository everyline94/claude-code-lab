# Skill: Anotações de Aula com Claude

Usa o Claude para transformar uma transcrição bruta do Whisper em anotações estruturadas em Markdown.

## Quando usar

Após gerar o arquivo bruto com `transcribe.sh` ou com o Agente 2 do orchestrator, quando o objetivo é produzir anotações de estudo em vez de texto corrido limpo.

## Fluxo

```
outputs/<nome>_bruto.txt  →  [Claude + prompt abaixo]  →  outputs/<nome>_anotacoes.md
```

## Prompt base

Envie ao Claude o conteúdo do arquivo `_bruto.txt` junto com o seguinte prompt:

---

```
Você receberá uma transcrição bruta de vídeo gerada pelo Whisper.
Detecte automaticamente o idioma do texto e produza o resultado no mesmo idioma.
Sua tarefa é transformá-la em anotações de aula estruturadas em Markdown.

ESTRUTURA DE SAÍDA:

# Título
Infira um título descritivo a partir do conteúdo principal.

## [Subtítulo por tema]
Para cada tema ou tópico abordado na transcrição, crie um subtítulo (##) e liste abaixo:
- Pontos principais em bullet points
- Inclua exemplos, dados e analogias mencionados
- Mantenha a ordem cronológica dos tópicos

## Conclusões
Liste os takeaways mais importantes, numerados:
1. Primeiro takeaway
2. Segundo takeaway
(etc.)

## Glossário
Liste os termos técnicos mencionados com definições curtas:
- **Termo**: definição em uma frase

REGRAS:
- REMOVA saudações, despedidas, chamadas para engajamento e logística
- PRESERVE todo conteúdo informativo, técnico, exemplos e analogias
- Use Markdown válido (headings, bullets, bold para termos-chave)
- Idioma: mesmo idioma da transcrição recebida (detectado automaticamente)

Ao final, adicione:
---
[RESUMO: X% do texto original condensado | Y termos no glossário | Idioma detectado: <idioma>]
```

---

## Como executar

Abra o Claude Code neste projeto e envie:
```
Leia outputs/<nome>_bruto.txt e aplique a skill skills/annotate.md.
Salve o resultado em outputs/<nome>_anotacoes.md.
```

## Convenção de nomes

| Arquivo | Descrição |
|---------|-----------|
| `outputs/<nome>_bruto.txt` | Transcrição original do Whisper, sem alterações |
| `outputs/<nome>_anotacoes.md` | Anotações estruturadas em Markdown geradas pelo Claude |

## Notas

- O arquivo bruto nunca deve ser sobrescrito — serve como referência e auditoria
- O idioma é detectado automaticamente — não é necessário ajustar o prompt por idioma
- O glossário só inclui termos que foram efetivamente mencionados na transcrição
- O formato Markdown permite visualização direta no GitHub, Notion ou qualquer editor
