# Construindo um Fluxo de Pesquisa Auto-Aprimorável com Claude Code, NotebookLM, Obsidian e Skill Creator

## O Conceito Central: Pesquisa Turbinada

- Combina quatro ferramentas em um único fluxo de trabalho unificado: **Claude Code**, **NotebookLM**, **Obsidian** e o **Skill Creator**
- Transforma o Claude Code em um sistema de pesquisa poderoso que pode ser configurado em menos de 30 minutos
- O caso de uso específico (pesquisa no YouTube) é apenas um modelo — o valor real está em **adaptá-lo a qualquer fonte de dados** (PDFs, artigos, texto, etc.)
- O fluxo de trabalho é altamente flexível e modular

## Arquitetura do Fluxo

- **Fonte de dados** (ex.: YouTube) → pesquisada via uma **skill** do Claude Code
- Os dados são enviados ao **NotebookLM** via Claude Code para análise
- O NotebookLM gera **entregáveis**: podcasts, vídeos, infográficos, apresentações de slides, mapas mentais, flashcards, etc.
- Os resultados são devolvidos ao **Claude Code**
- Todas as etapas são executadas por **skills** — subskills individuais são combinadas em uma **super skill** usando o Skill Creator

## O Papel do Obsidian

- Atua como a **camada de conhecimento persistente** do fluxo de trabalho
- Todos os dados analisados, métodos de análise, formatos de entregáveis e padrões de pensamento são salvos como **arquivos markdown** em um vault do Obsidian
- **Para o humano**: visão visual dos arquivos, conexões e relações baseadas em grafos
- **Para o Claude Code**: arquivos markdown são transparentes e facilmente pesquisáveis
- Com o tempo, o vault se torna um **corpus crescente de conhecimento** sobre as preferências de trabalho do usuário

## O Ciclo Auto-Aprimorável

- O arquivo **claude.md** é o "cérebro dentro do cérebro" — ele informa ao Claude Code as convenções, preferências e estilo de trabalho do usuário
- Quanto mais o fluxo roda, mais dados são registrados → o Claude Code **aprende e se adapta** ao longo do tempo
- Atualizar o claude.md é tão simples quanto pedir: _"Atualize o claude.md para refletir melhor meu estilo de trabalho e preferências de saída com base nas nossas últimas conversas"_
- **Efeito composto**: uma semana mostra melhoria modesta; meses e anos produzem um efeito significativo e duradouro
- Cria uma **relação simbiótica** onde todas as ferramentas se reforçam mutuamente

## Configuração: Passo a Passo

### 1. Instalar o Skill Creator
- Execute `/plugin` dentro do Claude Code
- Busque por **Skill Creator** e instale
- Saia e reinicie o Claude Code

### 2. Criar a Skill de Busca no YouTube
- Execute `/skill-creator` e descreva a skill desejada em linguagem natural
- Exemplo: _"Crie uma skill que busca no YouTube e retorna resultados de vídeo estruturados usando yt-dlp"_
- A skill é criada automaticamente dentro da pasta `.claude`

### 3. Configurar a Integração com o NotebookLM
- O NotebookLM **não tem API pública** — usa o repositório **notebook-lm-pi** do GitHub
- Instale executando os comandos do repositório no terminal (fora do Claude Code)
- Autentique com `notebook-lm login` → uma janela do navegador abre para login
- Crie uma skill para o NotebookLM via o comando `notebook-lm skill install` do repositório ou alimentando o repositório no Skill Creator
- Capacidades do NotebookLM: criar notebooks, adicionar até **50 fontes** (Drive, arquivos de texto, YouTube, etc.), gerar entregáveis (revisão em áudio, mapa mental, flashcards, infográfico, etc.)

### 4. Combinar em uma Super Skill de Pipeline
- Use `/skill-creator` novamente com um prompt descritivo do pipeline completo
- Especifique: busca no YouTube → análise no NotebookLM → geração de entregáveis
- O Skill Creator produz **uma skill unificada** que gerencia todo o fluxo

## Execução na Prática

- Um único comando executa o pipeline inteiro
- O processamento de IA para análise é feito pelo **NotebookLM** (terceirizado para o Google — sem custo extra de tokens)
- **Análise de texto**: rápida (minutos)
- **Entregáveis**: um infográfico leva alguns minutos; uma apresentação completa pode levar até 15 minutos
- A saída da pesquisa é salva como markdown no Obsidian com **backlinks** e **visualização em grafo**

## O Panorama Geral

- A fonte de dados é intercambiável (YouTube, PDFs, artigos, etc.)
- Até o NotebookLM pode ser substituído
- O modelo central é: **fluxo de trabalho + Obsidian + Skill Creator**
- Qualquer fluxo pode ser transformado em skills → combinado em uma super skill → conectado a esse pipeline auto-aprimorável

## Conclusões

1. A combinação de Claude Code + NotebookLM + Obsidian + Skill Creator cria um **sistema de pesquisa auto-aprimorável** que melhora com o uso
2. O **Skill Creator** permite combinar múltiplas subskills em uma skill de pipeline, eliminando a execução manual passo a passo
3. O **Obsidian** oferece tanto visão legível para humanos quanto persistência legível para máquinas, permitindo que o Claude Code aprenda preferências de trabalho ao longo do tempo
4. O **arquivo claude.md** é o mecanismo-chave para refinar o comportamento do Claude Code — ele cresce junto com o vault
5. Este modelo é **altamente modular** — troque fontes de dados, ferramentas de análise ou tipos de entregáveis mantendo a estrutura auto-aprimorável intacta
6. O NotebookLM terceiriza a análise de IA para o Google, o que significa **nenhum custo adicional de tokens** para processamento
7. O efeito composto do uso a longo prazo (meses/anos) produz uma **melhoria significativa e duradoura** no desempenho do Claude Code

## Glossário

- **Claude Code**: Ferramenta CLI da Anthropic para o Claude, usada como camada de orquestração do fluxo de trabalho
- **NotebookLM**: Ferramenta de pesquisa com IA do Google que analisa fontes e gera entregáveis (podcasts, infográficos, mapas mentais, etc.)
- **Obsidian**: Ferramenta de gestão de conhecimento baseada em markdown que funciona como um "segundo cérebro" com visualização em grafo
- **Skill Creator**: Plugin do Claude Code que gera skills reutilizáveis a partir de descrições em linguagem natural
- **Skill**: Conjunto de instruções reutilizáveis dentro da pasta `.claude` do Claude Code que define como executar uma tarefa específica
- **Super Skill**: Uma skill única que encadeia múltiplas subskills em um pipeline unificado
- **claude.md**: Arquivo de configuração que define as convenções, preferências e estilo de trabalho do Claude Code dentro de um projeto
- **Vault**: Pasta de workspace do Obsidian contendo arquivos markdown e suas interconexões
- **yt-dlp**: Ferramenta de linha de comando para baixar áudio/vídeo do YouTube e outras plataformas
- **notebook-lm-pi**: Repositório não-oficial do GitHub que fornece acesso via CLI ao NotebookLM
- **MCP (Model Context Protocol)**: Protocolo para conectar o Claude Code a ferramentas e serviços externos
- **Backlinks**: No Obsidian, referências que conectam documentos entre si, criando um grafo de conhecimento
