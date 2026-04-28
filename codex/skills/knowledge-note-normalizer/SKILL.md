---
name: knowledge-note-normalizer
description: Transforma qualquer entrada de conhecimento em uma nota Markdown padronizada, concisa e prática. Use quando Codex precisar converter links, textos, anotações, capturas transcritas ou conteúdo bruto em uma nota com título claro, tags em inglês, resumo técnico, caso de uso acionável e fonte, com fluxo de revisão no chat antes de salvar o resultado em arquivo .md.
---

# Knowledge Note Normalizer

Converta a entrada em uma nota Markdown única, objetiva e reutilizável. Preserve só a informação útil para recuperação e aplicação prática.

## Fluxo de Aprovação

Use sempre duas etapas:

1. Gere a nota no chat no formato obrigatório.
2. Não salve nada na primeira resposta.
3. Aguarde o usuário pedir ajustes ou aprovar explicitamente.
4. Quando o usuário aprovar, salve a nota em `.md`.
5. Após salvar, informe o caminho final do arquivo.

Trate mensagens como `aprovado`, `pode salvar`, `salva isso`, `ok, salva`, `fechado` como autorização explícita para gravar o arquivo.
Trate qualquer pedido de mudança como revisão da nota atual, sem salvar ainda.

## Fluxo

1. Identifique o tema central da entrada.
2. Gere um título curto, claro e direto.
3. Extraia de 3 a 5 tags essenciais em inglês.
4. Resuma o conteúdo com foco técnico.
5. Defina um caso de uso específico e executável.
6. Inclua a fonte quando houver link explícito.

## Regras de Saída

- Gere um `TÍTULO` claro e direto.
- Gere entre `3` e `5` `TAGS`.
- Escreva as tags em inglês.
- Escreva todas as tags em minúsculas.
- Use o formato `#tag`.
- Escolha palavras simples e estáveis.
- Evite sinônimos redundantes e tags quase duplicadas.
- Escreva um `RESUMO` curto, técnico e sem enrolação.
- Escreva um `CASO DE USO` prático, específico, acionável e focado em aplicação real.
- Se houver link na entrada, inclua-o em `FONTE`.
- Se não houver fonte identificável, use `N/A`.

## Salvamento

- Salve somente após aprovação explícita do usuário.
- Use a pasta `notes/` no diretório de trabalho atual como destino padrão quando o usuário não indicar outra pasta.
- Se a pasta de destino não existir, crie-a.
- Gere o nome do arquivo de forma curta e direta.
- Quando houver `FONTE` com URL clara, prefira o último slug relevante da URL como nome do arquivo.
- Exemplo: `https://apps.shopify.com/smart-seo` vira `smart-seo.md`.
- Só use o título aprovado como base do nome quando não houver slug útil na fonte.
- Normalize o nome do arquivo para minúsculas com hífens.
- Remova acentos, pontuação supérflua e espaços duplicados no nome do arquivo.
- Use a extensão `.md`.
- Use o script `scripts/save_note.py` quando precisar gravar o arquivo.

## Critérios de Escrita

- Não explique demais.
- Não use linguagem genérica.
- Não repita conteúdo entre seções.
- Priorize utilidade prática.
- Seja conciso e direto.
- Não invente detalhes que não estejam sustentados pela entrada.
- Se a entrada for fraca ou fragmentada, normalize o que for possível sem extrapolar.

## Heurísticas

- O título deve refletir o conceito principal, não o formato da entrada.
- As tags devem cobrir assunto, domínio e aplicação quando isso agregar busca futura.
- Prefira termos curtos e universais em inglês, como `#seo`, `#conversion`, `#analytics`, `#automation`.
- O resumo deve descrever a ideia central ou técnica principal em poucas linhas.
- O caso de uso deve indicar como aplicar a informação em uma situação real.
- Se houver múltiplos links, use o mais relevante como fonte principal.
- Se a entrada já vier estruturada, reescreva no formato obrigatório sem copiar excessivamente.

## Formato Obrigatório

Sempre responda exatamente neste formato Markdown:

```md
# {Titulo}

Tags: {tags}

## Resumo
{resumo}

## Caso de Uso
{caso_de_uso}

## Fonte
{fonte ou "N/A"}
```

## Regras de Interação

- Na primeira resposta, entregue apenas a nota.
- Se o usuário pedir mudança, reescreva a nota inteira já com o ajuste.
- Se o usuário aprovar, salve a versão mais recente sem reformatar novamente.
- Se houver ambiguidade sobre a pasta de destino, use `notes/`.
