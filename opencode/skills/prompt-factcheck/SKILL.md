---
name: prompt-factcheck
description: Verify factual claims, API assumptions, policy references, version statements, and unsupported assertions inside a prompt or prompt package. Produces a claim-by-claim verification report with evidence and correction guidance. Trigger - requests like "fact-check this prompt", "verify these prompt assumptions", or "check whether this prompt says true things about the API/policy".
---

## What I do

Audit the truthfulness and support level of factual content inside a prompt:
1. Read the prompt or prompt package
2. Extract atomic factual claims
3. Rank claims by impact and risk
4. Verify each claim against authoritative sources
5. Classify each claim as supported, contradicted, outdated, unverifiable, or ambiguous
6. Recommend corrections and stop for user action

## When to use me

- User asks to verify statements inside a prompt
- A prompt references APIs, policies, model behavior, pricing, capabilities, or standards
- A prompt may contain stale assumptions copied from old docs or internet examples
- A reviewed prompt has been flagged with `Factcheck needed`

## WORKFLOW

### STEP 1: Intake the prompt package

Accept:
- raw prompt text
- a prompt file path
- a prompt package with notes, cited docs, examples, API assumptions, or policy references

First identify which parts contain factual or normative claims.

### STEP 2: Extract atomic claims

Break the prompt into checkable claims such as:
- "Model X supports feature Y"
- "The API requires parameter Z"
- "Policy A forbids action B"
- "This output format is guaranteed"
- "The tool behaves this way"

Ignore pure stylistic or rhetorical language unless it implies a factual guarantee.

### STEP 3: Rank claims by risk

Prioritize claims that can cause:
- broken integrations
- unsafe or non-compliant behavior
- hallucinated authority
- outdated implementation instructions
- incorrect tool or model usage

### STEP 4: Verify using authoritative sources

Use the strongest available sources first:
- official vendor docs
- official API references
- standards or policy documents
- first-party cookbooks or technical docs
- only then high-signal secondary sources if necessary

For each claim, capture:
- the exact claim
- where it appears
- what source was checked
- what the source actually supports
- whether the claim is current or stale

### STEP 5: Assign verification verdicts

Use only these verdicts:
- **SUPPORTED** — clearly backed by evidence
- **CONTRADICTED** — evidence says the claim is false
- **OUTDATED** — once true or plausible, but no longer current
- **UNVERIFIABLE** — not enough reliable evidence found
- **AMBIGUOUS** — wording is too vague to verify cleanly

### STEP 6: Present the fact-check report

Use this STRICT output format:

```markdown
## Prompt Factcheck: {NAME}

**Claims reviewed**: {N}
**High-risk claims**: {M}

### 1) Claim Verification

| # | Claim | Location | Verdict | Evidence | Impact |
|---|-------|----------|---------|----------|--------|
| 1 | ... | section X | SUPPORTED | ... | Low |

### 2) Critical Corrections
- {claim/problem} → {recommended correction}

### 3) Claims Needing Rewrite
- {ambiguous or unverifiable claim} → {safer rewrite}

### 4) Risk Notes
- {important consequence if left unchanged}

### 5) Recommended Next Action
- `review` — improve prompt structure after correcting claims
- `source` — gather stronger references for unsupported areas
- `done` — fact-check complete
```

### STEP 7: Stop for user action

Wait for the user to choose what to do next. Do NOT proceed without explicit instruction.

## Hard rules

- NEVER guess when evidence is weak or missing
- NEVER flatten uncertainty into false certainty
- NEVER broaden this into a full prompt-quality critique — hand off to `prompt-review`
- NEVER broaden this into open-ended pattern research — hand off to `prompt-source`
- Prefer fewer strong sources over many weak ones
- If sources disagree, explain the disagreement instead of hiding it
- Answer in the same language the user uses
