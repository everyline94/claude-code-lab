# Criando um Agente Pessoal de IA com Google AntiGravity (Alternativa ao OpenClaw)

## Por que criar seu próprio agente

- Usar um assistente de IA totalmente de terceiros (como o OpenClaw) oferece velocidade, mas traz riscos de privacidade: não se controla quem acessa, o que é registrado ou o que pode vazar
- A alternativa é criar um agente pessoal sob medida usando o **Google AntiGravity**, construindo tudo do zero
- O agente opera 100% local no computador do usuário, recebe comandos pelo **Telegram** e suporta múltiplos LLMs dinamicamente

## Configuração inicial do projeto

- O projeto parte de arquivos de especificação (specs) que definem os requisitos de software
- As specs incluem: documento de requisitos (PRD), arquitetura do projeto, agent loop (loop principal do agente) e skill loader
- As specs funcionam como prompts estruturados — o AntiGravity lê e desenvolve o software automaticamente
- O AntiGravity usa **TypeScript** por padrão, mas pode-se solicitar que refaça para Python, Java ou outra linguagem
- Basta arrastar as specs para dentro do AntiGravity e dar o comando por texto ou áudio para ele construir tudo
- O AntiGravity instala Node.js, cria interfaces orientadas a objeto, banco de dados SQLite e configura a interface com o Telegram

## Configuração do Telegram

- Acessar o **Web Telegram** no navegador (similar ao Web WhatsApp, lê QR Code)
- Procurar pelo **BotFather** e usar o comando `/newbot`
- Definir nome do bot (ex: "SanderClaw") e username (deve terminar com `_bot`)
- Copiar o token de acesso gerado e colar no arquivo `.env` do projeto (campo `TELEGRAM_BOT_TOKEN`)
- O arquivo `.env` é criado renomeando o `.env.example` (removendo ".example")

## Segurança: restrição de acesso

- Configurar `TELEGRAM_ALLOWED_USER_IDS` no `.env` para que o bot só responda ao dono
- Para descobrir o ID do Telegram: procurar pelo bot **GetID** no Telegram e copiar o ID retornado
- Após configurar, o bot ignora mensagens de qualquer outro usuário

## Configuração das chaves de API dos LLMs

- Acessar o **AI Studio** do Google e gerar uma chave de API para o Gemini
- Colar a chave no `.env` do projeto
- Também é possível usar **DeepSeek**, **OpenAI** ou qualquer outro LLM — basta informar ao AntiGravity qual usar como padrão
- Para trocar de LLM, é só comunicar ao AntiGravity e ele reconfigura

## Primeira execução e correção de erros

- Na primeira execução, usar o comando `npm run dev`
- É normal surgirem erros na primeira vez (mesmo programadores experientes enfrentam isso)
- O AntiGravity identifica e corrige os problemas automaticamente (ex: bibliotecas faltando do Node)
- Após correções, o sistema exibe: "SanderClaw iniciando em background, aguardando interações pelo Telegram"

## Sistema de Skills

- Skills são habilidades que se adicionam ao agente arrastando arquivos para a pasta `skills/` do projeto
- O agente carrega as skills automaticamente ao iniciar, sem necessidade de reiniciar o processo principal
- Exemplo demonstrado: skill **Legal Document Explainer** — analisa contratos jurídicos e políticas de privacidade
- Para adicionar uma nova skill, basta criar com o Skill Creator (do Claude ou do AntiGravity) e arrastar para a pasta
- Após adicionar, reiniciar o agente para que ele reconheça a nova skill

## Suporte a múltiplos formatos de entrada

- Por padrão, o agente só aceita texto
- Usando a spec `telegram_input`, é possível habilitar: **PDF**, **Markdown**, **áudio** e **Excel**
- Áudio é transcrito localmente com **Whisper** (modelo local, nada vai para servidores externos)
- O processo de áudio: arquivo temporário → transcrição com Whisper → remoção do temporário → resposta

## Demonstração: skill de títulos para YouTube

- Foi adicionada uma skill **YouTube Optimization** que avalia e sugere títulos otimizados
- Fluxo: usuário envia áudio com ideia de título → Whisper transcreve → skill analisa e pontua de 0 a 10 → sugere títulos alternativos com notas
- A skill segue passos definidos: (1) análise e pontuação do título original, (2) sugestão de títulos otimizados

## Extensibilidade com MCPs

- Além de skills, é possível habilitar **MCPs** (Model Context Protocols) que conectam o agente a ferramentas externas
- Exemplos: Google Drive, Google Calendar (para agendamento de eventos)
- O agente pode receber novas habilidades continuamente, transformando-se num assistente cada vez mais completo

## Conclusões

1. É possível criar um agente pessoal de IA sem depender de serviços terceiros, operando 100% local
2. O Google AntiGravity constrói o software completo a partir de specs/prompts estruturados, sem necessidade de programar manualmente
3. O Telegram serve como interface de comunicação simples e acessível com o agente
4. Skills são modulares e plug-and-play — basta arrastar para a pasta e reiniciar
5. O sistema suporta múltiplos LLMs (Gemini, DeepSeek, OpenAI) e múltiplos formatos de entrada (texto, áudio, PDF, Markdown, Excel)
6. A segurança é garantida pela restrição de user ID no Telegram e pela execução local

## Glossário

- **AntiGravity**: ferramenta do Google para construção de software a partir de especificações/prompts (ambiente de desenvolvimento assistido por IA)
- **OpenClaw**: plataforma de agentes de IA de terceiros (alternativa que o vídeo propõe substituir)
- **BotFather**: bot oficial do Telegram para criação e gerenciamento de bots
- **Specs**: arquivos de especificação de requisitos de software (PRD, arquitetura, etc.)
- **PRD**: Product Requirements Document — documento principal de requisitos do software
- **Agent Loop**: loop principal que mantém o agente em execução, processando mensagens recebidas
- **Skill Loader**: módulo que carrega automaticamente skills da pasta de habilidades do agente
- **Skill**: arquivo de prompt/instrução que define uma habilidade específica do agente
- **LLM**: Large Language Model — modelo de linguagem usado pelo agente para gerar respostas (ex: Gemini, GPT, DeepSeek)
- **MCP**: Model Context Protocol — protocolo que conecta o agente a ferramentas externas (Google Drive, Calendar, etc.)
- **Whisper**: modelo local da OpenAI para transcrição de áudio em texto
- **Nodeemon/Nodemon**: ferramenta Node.js que reinicia automaticamente o servidor durante desenvolvimento
- **dotenv (.env)**: arquivo de variáveis de ambiente com chaves de API e configurações sensíveis
- **AI Studio**: plataforma do Google para obter chaves de API do Gemini

---
[RESUMO: ~45% do texto original condensado | 14 termos no glossário | Idioma detectado: Português]
