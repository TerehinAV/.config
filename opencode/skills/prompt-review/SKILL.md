---
name: prompt-review
description: Critique an existing prompt or prompt package for clarity, structure, ambiguity, contradictions, failure modes, and evaluability. Produces a focused review with targeted rewrite guidance. Trigger - requests like "review this prompt", "critique this prompt", "why is this prompt weak", or "improve prompt quality".
---

## What I do

Review an existing prompt as a prompt engineer would:
1. Read the prompt or prompt package
2. Infer the intended behavior and success criteria
3. Evaluate structure, constraints, examples, and likely failure modes
4. Categorize issues by severity
5. Recommend targeted rewrites instead of vague advice
6. Stop and ask what to do next

## When to use me

- User asks to review, critique, or improve an existing prompt
- A prompt feels vague, contradictory, overly verbose, or fragile
- User wants a second opinion before using a prompt in production
- A prompt package needs structural cleanup without a full rewrite from scratch

## WORKFLOW

### STEP 1: Intake the prompt package

Accept:
- raw prompt text
- a prompt file path
- a prompt package with examples, output requirements, model assumptions, policies, and wrapper instructions

Determine:
- the real objective of the prompt
- expected inputs and outputs
- whether the prompt is system-level, task-level, or workflow-level
- whether it includes examples, tools, refusal logic, or verification instructions

### STEP 2: Build the review rubric

Review the prompt against these dimensions:
- goal clarity
- relevance and sufficiency of context
- explicitness of constraints
- instruction ordering and priority
- output format clarity
- example quality
- robustness to ambiguity
- likely failure modes
- evaluability and testability

### STEP 3: Inspect for structural issues

Look for problems such as:
- vague or conflicting goals
- missing constraints
- buried critical instructions
- unclear tool-use boundaries
- underspecified output format
- examples that accidentally overfit the model
- verbosity that adds noise instead of precision
- policy or fact references that appear questionable

If factual claims seem suspicious, flag them as `Factcheck needed` rather than deciding their truth here.

### STEP 4: Simulate failure modes

Test the prompt mentally against realistic edge cases:
- ambiguous user input
- missing context
- conflicting instructions
- long-context overload
- tool misuse
- hallucination-prone tasks
- over-compliance with examples

### STEP 5: Categorize issues

Use these severity levels:
- **CRITICAL** — prompt is likely to fail, mislead, or produce unsafe/unusable output
- **MAJOR** — prompt can work but has serious ambiguity, conflict, or weak structure
- **MINOR** — quality, maintainability, or readability issues
- **INFO** — useful observations and optional improvements

### STEP 6: Present the review

Use this STRICT output format:

```markdown
## Prompt Review: {NAME}

**Goal inferred**: {one concise sentence}
**Overall verdict**: {Strong | Needs revision | Weak}

### 1) Strengths
- {strength 1}
- {strength 2}

### 2) Critical Issues ({COUNT})

#### [{N}] {short title}
**Why it matters**: {impact}
**Fix**: {targeted rewrite guidance}

### 3) Major Issues ({COUNT})

#### [{N}] {short title}
**Why it matters**: {impact}
**Fix**: {targeted rewrite guidance}

### 4) Minor / Maintainability ({COUNT})
- [{N}] {issue} → {fix}

### 5) Failure Modes to Test
- {case 1}
- {case 2}

### 6) Recommended Rewrites
- {highest-priority rewrite}
- {second rewrite}

### 7) Handoffs
- `source` — if the prompt needs stronger external grounding
- `factcheck` — if the prompt contains disputed facts, stale APIs, or policy claims
- `done` — review complete
```

### STEP 7: Stop for user action

Wait for the user to choose what to do next. Do NOT proceed without explicit instruction.

## Hard rules

- NEVER treat style preferences as major defects unless they affect correctness or reliability
- NEVER verify factual claims here — hand off to `prompt-factcheck`
- NEVER do broad source research here — hand off to `prompt-source`
- NEVER silently rewrite the whole prompt unless the user explicitly asks
- Prefer the smallest effective rewrite over complete replacement
- Be critical but concrete: every significant issue should have a fix direction
- Answer in the same language the user uses
