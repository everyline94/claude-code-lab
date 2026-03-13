# Orchestrator — Pipeline com Sub-Agentes

Define o pipeline de transcrição como três sub-agentes especializados e independentes, substituindo o `transcribe.sh` monolítico para uso dentro do Claude Code.

---

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

### Agente 3 — Limpeza

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

## Pipeline completo — instrução única

Para acionar os três agentes em sequência com uma única mensagem ao Claude Code:

```
Execute o pipeline completo de transcrição para <URL>:

1. Agente Download: use skills/download.md para baixar o áudio de <URL>
   → confirme o caminho do .mp3 antes de continuar

2. Agente Transcrição: use skills/transcribe.md para transcrever o .mp3
   → salve em outputs/<título>_bruto.txt e confirme antes de continuar

3. Agente Limpeza: use skills/clean.md para limpar outputs/<título>_bruto.txt
   → salve o resultado em outputs/<título>_limpo.txt

Se qualquer etapa falhar, pare e informe em qual agente ocorreu o erro.
```

---

## Reexecução parcial

Se uma etapa falhar ou precisar ser refeita, basta reexecutar o agente correspondente:

| Situação | Solução |
|----------|---------|
| Download falhou | Reexecutar apenas o Agente 1 |
| Transcrição com qualidade ruim | Reexecutar apenas o Agente 2 com outro modelo |
| Limpeza insatisfatória | Reexecutar apenas o Agente 3 ajustando o prompt |
| Áudio já existe em `/tmp/` | Pular o Agente 1 e iniciar no Agente 2 |
| Bruto já existe em `outputs/` | Pular os Agentes 1 e 2 e reexecutar só o Agente 3 |

---

## Relação com transcribe.sh

O `transcribe.sh` continua disponível para uso direto no terminal (sem o Claude Code). O orchestrator é a alternativa para uso **dentro de uma sessão do Claude Code**, com mais controle e rastreabilidade.

| Modo | Quando usar |
|------|-------------|
| `./transcribe.sh <URL>` | Uso direto no terminal, sem Claude Code |
| `orchestrator.md` | Uso dentro do Claude Code, com controle por etapa |
