---
name: prompt-source
description: Research prompt patterns, official guidance, and reusable references for an existing or planned prompt. Builds a cited source brief from vendor docs, GitHub examples, and selective web research. Trigger - requests like "research prompt patterns", "find prompt examples", "source this prompt", or "what should this prompt be based on".
---

## What I do

Research the evidence and patterns that should inform a prompt or prompt package:
1. Read the prompt, brief, or prompt package
2. Extract the key research questions and missing context
3. Search official docs, trusted examples, and relevant repositories
4. Rank findings by authority, freshness, and relevance
5. Map sources and patterns to concrete prompt sections
6. Present a structured source brief with citations and next actions

## When to use me

- User wants to ground a prompt in official or high-quality sources
- User asks to "find prompt examples", "research best practices", or "source this prompt"
- User has a large prompt and wants to know what it should be based on
- User wants reusable patterns before writing or rewriting a prompt

## WORKFLOW

### STEP 1: Intake the prompt package

Accept any of these as input:
- raw prompt text
- a prompt file path
- a prompt package containing prompt text, assumptions, examples, policy references, API notes, or target model info

First determine:
- the prompt's goal
- target model or platform (if known)
- domain or use case
- what is already grounded vs what is unsupported
- what specific questions need sourcing

If the prompt package is incomplete, list the missing pieces but continue with the available material.

### STEP 2: Build a research plan

Extract 3-10 concrete research questions such as:
- What official prompting guidance exists for this model?
- What output format patterns are recommended?
- What tool-use or function-calling constraints apply?
- What common failure modes or caveats are documented?
- Are there strong open-source prompt examples in similar workflows?

### STEP 3: Search sources in priority order

Use sources in this order unless the user specifies otherwise:

1. **Official vendor docs**
   - OpenAI docs/cookbooks
   - Anthropic docs
   - Google Gemini docs
   - framework-specific docs when relevant

2. **Authoritative technical references**
   - official SDK docs
   - standards or platform docs
   - official policy/reference pages

3. **High-signal public examples**
   - reputable GitHub repos
   - well-maintained prompt libraries
   - engineering writeups with concrete examples

4. **Selective web search**
   - only when the previous tiers are insufficient

For each source, capture:
- title / name
- source type
- why it is relevant
- freshness if it matters
- exact claim or pattern you are taking from it

### STEP 4: Extract reusable patterns

For each good source, distill reusable patterns such as:
- instruction ordering
- constraint framing
- output contract design
- tool-use rules
- example structure
- fallback behavior
- refusal/safety boundaries

Do not just copy prompt text. Extract the pattern and explain why it matters.

### STEP 5: Map sources to prompt sections

Create a source map tying evidence to likely prompt sections:
- goal / role
- context
- constraints
- output format
- examples
- verification or refusal behavior

Also identify gaps:
- what still lacks strong evidence
- where the prompt likely needs review
- where factual verification may still be required

### STEP 6: Present the source brief

Use this STRICT output format:

```markdown
## Prompt Source Brief: {NAME}

**Goal**: {one concise sentence}
**Target model / platform**: {known or unknown}
**Research questions**: {N}

### 1) Best Sources

| # | Source | Type | Why it matters | Trust |
|---|--------|------|----------------|-------|
| 1 | ... | Official docs | ... | High |

### 2) Reusable Patterns

#### Pattern A: {short name}
**Taken from**: {source(s)}
**What to reuse**: {pattern}
**Why**: {short rationale}

### 3) Source Map

| Prompt Section | Recommended basis | Source(s) |
|----------------|-------------------|-----------|
| Goal / role | ... | ... |
| Constraints | ... | ... |

### 4) Gaps / Missing Evidence
- {gap 1}
- {gap 2}

### 5) Recommended Next Action
- `draft` — write or rewrite the prompt using these sources
- `review` — critique the current prompt structure
- `factcheck` — verify factual or policy claims inside the prompt
- `done` — sourcing complete
```

### STEP 7: Stop for user action

Wait for the user to choose the next step. Do NOT proceed without explicit instruction.

## Hard rules

- ALWAYS prefer official docs over community content when both exist
- NEVER present weak community prompts as authoritative guidance
- NEVER claim a fact is verified without citing the source that supports it
- NEVER turn this skill into a prompt-quality review — hand off to `prompt-review`
- NEVER turn this skill into factual adjudication of disputed claims — hand off to `prompt-factcheck`
- Extract **patterns**, not cargo-cult copies of long prompts
- Answer in the same language the user uses
