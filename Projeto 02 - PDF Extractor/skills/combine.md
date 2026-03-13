# Skill: Combinar Descrição + Mapa Mental → Documento de Estudo

## Objetivo

Ler os dois arquivos de input de uma aula (descrição + mapa mental extraído do PDF) e gerar um documento de estudo estruturado em Markdown.

## Inputs

- `inputs/<nome>_descricao.txt` — descrição da aula (texto colado pelo usuário)
- `inputs/<nome>_mapa.txt` — texto extraído do PDF do mapa mental

## Output

- `outputs/<nome>_estudo.md` — documento de estudo pronto para colar no Google Docs

## Instruções para o Claude

Leia os dois arquivos de input e gere o documento de estudo seguindo esta estrutura exata:

```markdown
# [Título da Aula]
**Participante:** [Nome]

## Resumo Executivo
[3-4 linhas sintetizando o essencial da aula: o que foi ensinado, qual o objetivo principal e a principal sacada]

## Mapa Lógico
[Progressão da aula em formato de fluxo visual usando setas]
Tema A → Tema B → Tema C → Conclusão

## Conceitos-Chave
- **[Conceito 1]:** Definição curta + em que contexto se aplica
- **[Conceito 2]:** Definição curta + em que contexto se aplica
[Listar todos os conceitos relevantes]

## Aplicações Práticas
- [Ação concreta 1 derivada do conteúdo]
- [Ação concreta 2 derivada do conteúdo]
[Foco em o que fazer com o conhecimento]

## Frases-Chave
> "Citação marcante 1"

> "Citação marcante 2"

[Frases impactantes ditas na aula que capturam a essência do conteúdo]

## Glossário
- **[Termo 1]:** Definição no contexto específico da aula
- **[Termo 2]:** Definição no contexto específico da aula
```

## Ortografia

- O output SEMPRE deve ter ortografia correta em português
- Todos os acentos, cedilhas e caracteres especiais devem estar presentes e corretos
- Se o input tiver caracteres corrompidos ou sem acentuação (comum em extrações de PDF), corrija automaticamente no output
- Nunca produza palavras sem acento quando o português exige acento

## Regras

1. **Detectar título e participante** automaticamente a partir da descrição
2. **Cruzar informações**: usar a descrição (timestamps, highlights, blocos) para conteúdo detalhado e o mapa mental para estrutura e hierarquia dos temas
3. **Markdown limpo**: usar apenas `#`, `##`, `-`, `>`, `**bold**` — sem tabelas, sem HTML, sem emojis
4. **Sempre em português**
5. **Resumo Executivo**: deve capturar a essência da aula em 3-4 linhas, sem ser genérico
6. **Mapa Lógico**: mostrar a progressão real dos temas da aula, não uma lista — usar setas (→) para indicar fluxo
7. **Conceitos-Chave**: cada conceito deve ter definição + contexto de uso, não apenas o nome
8. **Aplicações Práticas**: foco em ações concretas, não em conceitos abstratos
9. **Frases-Chave**: priorizar citações que carregam insight, não frases genéricas
10. **Glossário**: apenas termos técnicos ou específicos do contexto da aula que precisam de explicação
11. **Nome do arquivo**: derivado do título da aula em snake_case (ex: `mvps_estudo.md`, `growth_hacking_estudo.md`)
