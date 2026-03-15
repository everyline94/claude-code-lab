# Orchestrator — Pipeline com Sub-Agentes

Define o pipeline de transcrição como três sub-agentes especializados e independentes, substituindo o `transcribe.sh` monolítico para uso dentro do Claude Code.

---

## Comportamento ao receber uma URL

Ao receber uma URL, o agente deve **imediatamente** responder com uma frase curta confirmando a ação antes de iniciar o pipeline. Exemplo:

> Vou baixar o áudio, transcrever e gerar o texto limpo + anotações.

Não pergunte nada — apenas confirme e execute.

## Conceito

Em vez de um único script que faz tudo em sequência, o pipeline é dividido em **agentes autônomos** — cada um responsável por uma etapa, com entradas e saídas bem definidas. O Claude Code orquestra a execução chamando cada agente na ordem certa.

**Vantagens:**
- **Reexecução granular:** se a transcrição falhar, não é preciso baixar o áudio de novo
- **Rastreabilidade:** cada etapa produz um artefato verificável antes de avançar
- **Composibilidade:** os agentes podem ser combinados em ordens diferentes ou usados isoladamente
- **Paralelismo futuro:** agentes independentes podem rodar em paralelo quando não há dependência

---

## Sub-agentes

### Agente 1 — Download

**Responsabilidade:** baixar o áudio de uma URL e salvar em `/tmp/`

**Skill:** `skills/download.md`

**Entrada:** URL do vídeo (YouTube, TikTok, Instagram)

**Saída:** `/tmp/<título_do_vídeo>.mp3`

**Instrução para o Claude:**
```
Use a skill skills/download.md para baixar o áudio de <URL>.
Confirme o caminho completo do arquivo gerado antes de continuar.
```

---

### Agente 2 — Transcrição

**Responsabilidade:** transcrever o arquivo de áudio com Whisper e salvar como `_bruto.txt`

**Skill:** `skills/transcribe.md`

**Entrada:** caminho do `.mp3` gerado pelo Agente 1

**Saída:** `outputs/<título>_bruto.txt`

**Instrução para o Claude:**
```
Use a skill skills/transcribe.md para transcrever <caminho_do_mp3>.
Salve o resultado em outputs/ e renomeie para <título>_bruto.txt.
Confirme que o arquivo existe antes de continuar.
```

---

### Agente 3A — Limpeza (Modo 1)

**Responsabilidade:** limpar e coesar a transcrição bruta com o prompt da `clean.md`

**Skill:** `skills/clean.md`

**Entrada:** `outputs/<título>_bruto.txt`

**Saída:** `outputs/<título>_limpo.txt`

**Instrução para o Claude:**
```
Leia outputs/<título>_bruto.txt e aplique a skill skills/clean.md.
Salve o resultado em outputs/<título>_limpo.txt.
```

---

### Agente 3B — Anotações (Modo 2)

**Responsabilidade:** gerar anotações de aula estruturadas em Markdown a partir da transcrição bruta

**Skill:** `skills/annotate.md`

**Entrada:** `outputs/<título>_bruto.txt`

**Saída:** `outputs/<título>_anotacoes.md`

**Instrução para o Claude:**
```
Leia outputs/<título>_bruto.txt e aplique a skill skills/annotate.md.
Salve o resultado em outputs/<título>_anotacoes.md.
```

---

## Pipeline padrão

**Sempre execute ambos os modos** após gerar o bruto — não pergunte ao usuário.

| Pipeline | Agentes | Saídas finais |
|----------|---------|---------------|
| **Completo (padrão)** | Agente 1 → 2 → 3A + 3B | `_limpo.txt` + `_anotacoes.md` |

---

## Pipeline completo — instrução única

```
Execute o pipeline completo de transcrição para <URL>:

1. Agente Download: use skills/download.md para baixar o áudio de <URL>
   → confirme o caminho do .mp3 antes de continuar

2. Agente Transcrição: use skills/transcribe.md para transcrever o .mp3
   → salve em outputs/<título>_bruto.txt e confirme antes de continuar

3. Agente Limpeza: use skills/clean.md para limpar outputs/<título>_bruto.txt
   → salve o resultado em outputs/<título>_limpo.txt

4. Agente Anotações: use skills/annotate.md para anotar outputs/<título>_bruto.txt
   → salve o resultado em outputs/<título>_anotacoes.md

Se qualquer etapa falhar, pare e informe em qual agente ocorreu o erro.
```

---

## Reexecução parcial

Se uma etapa falhar ou precisar ser refeita, basta reexecutar o agente correspondente:

| Situação | Solução |
|----------|---------|
| Download falhou | Reexecutar apenas o Agente 1 |
| Transcrição com qualidade ruim | Reexecutar apenas o Agente 2 com outro modelo |
| Limpeza insatisfatória | Reexecutar apenas o Agente 3A ajustando o prompt |
| Anotações insatisfatórias | Reexecutar apenas o Agente 3B ajustando o prompt |
| Áudio já existe em `/tmp/` | Pular o Agente 1 e iniciar no Agente 2 |
| Bruto já existe em `outputs/` | Pular os Agentes 1 e 2 e reexecutar só o Agente 3A ou 3B |
| Trocar de modo após transcrição | Executar Agente 3A ou 3B sobre o bruto existente |

---

## Relação com transcribe.sh

O `transcribe.sh` continua disponível para uso direto no terminal (sem o Claude Code). O orchestrator é a alternativa para uso **dentro de uma sessão do Claude Code**, com mais controle e rastreabilidade.

| Modo | Quando usar |
|------|-------------|
| `./transcribe.sh <URL>` | Uso direto no terminal, sem Claude Code |
| `orchestrator.md` | Uso dentro do Claude Code, com controle por etapa |
