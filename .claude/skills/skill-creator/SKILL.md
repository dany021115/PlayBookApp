---
name: skill-creator
description: This skill should be used when creating a new skill or reviewing/updating an existing skill. It provides guidelines for designing effective Claude Skills with specialized knowledge, workflows, and tool integrations.
---

# Skill Creator

Guidance for creating and reviewing skills that extend Claude's capabilities with specialized knowledge, workflows, and tools.

## About Skills

Skills are modular, self-contained packages that provide:
1. **Specialized workflows** — Multi-step procedures for specific domains
2. **Tool integrations** — Instructions for working with specific file formats or APIs
3. **Domain expertise** — Project-specific knowledge, schemas, business logic
4. **Bundled resources** — Scripts, references, and assets for complex and repetitive tasks

## Skill Anatomy

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (required: name, description)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/       — Executable code for deterministic, repeatable tasks
    ├── references/    — Documentation loaded into context as needed
    └── assets/        — Files used in output (templates, icons, fonts)
```

## Progressive Disclosure Principle

Manage context efficiently with three loading levels:

1. **Metadata** (name + description) — Always in context (~100 words)
2. **SKILL.md body** — Loaded when skill triggers (<5k words target)
3. **Bundled resources** — Loaded as needed (unlimited)

Keep SKILL.md lean. Move detailed reference material, schemas, and large tables to `references/` files.

## SKILL.md Requirements

### Frontmatter

```yaml
---
name: skill-name
description: This skill should be used when [specific trigger]. It [what it does].
---
```

- `name`: kebab-case, matches directory name
- `description`: Use third-person ("This skill should be used when..." not "Use this skill when..."). Be specific about triggers and functionality.

### Writing Style

- Use **imperative/infinitive form** (verb-first instructions), not second person
- Write "To accomplish X, do Y" — not "You should do X"
- Focus on information that is beneficial and non-obvious to Claude
- Include only procedural knowledge and domain-specific details that Claude would not infer

### Content Structure

Answer these questions in the SKILL.md body:

1. What is the purpose of the skill?
2. When should the skill be used?
3. How should Claude execute the skill? Reference all bundled resources.

## Bundled Resources Guidelines

### Scripts (`scripts/`)

- Include when the same code is rewritten repeatedly or deterministic reliability is needed
- Token-efficient: can be executed without loading into context
- Example: `scripts/validate_schema.py` for schema validation tasks

### References (`references/`)

- Include for documentation that informs Claude's process
- Use for: database schemas, API docs, design token tables, domain knowledge
- If files are large (>10k words), include grep search patterns in SKILL.md
- Information should live in either SKILL.md or references, not both

### Assets (`assets/`)

- Include files used in output: templates, images, boilerplate code
- Separates output resources from documentation

## Skill Creation Process

### Step 1: Understand Usage with Concrete Examples

Gather concrete examples of how the skill will be used. Ask:
- What functionality should the skill support?
- What would a user say or do that should trigger this skill?
- What are the expected inputs and outputs?

### Step 2: Plan Reusable Contents

Analyze each example to identify:
- **Scripts** for repeated code patterns
- **References** for schemas, docs, or domain knowledge
- **Assets** for templates or boilerplate

### Step 3: Create the Skill

Create the directory structure and SKILL.md with proper frontmatter.

### Step 4: Edit and Refine

- Start with bundled resources (scripts, references, assets)
- Remove any directories not needed
- Write SKILL.md following the writing style and content structure guidelines
- Ensure all bundled resources are referenced in SKILL.md

### Step 5: Validate

Check the skill against this checklist:
- [ ] YAML frontmatter has `name` and `description`
- [ ] Description uses third-person and specifies trigger
- [ ] Writing uses imperative form, not second person
- [ ] SKILL.md body is under 5k words
- [ ] Large reference material is in `references/`, not inline
- [ ] No duplicate information between SKILL.md and references
- [ ] All bundled resources are referenced in SKILL.md
- [ ] Directory name matches `name` in frontmatter

### Step 6: Iterate

After real-world usage:
1. Identify struggles or inefficiencies
2. Update SKILL.md or bundled resources
3. Test again

## Review Checklist for Existing Skills

When reviewing an existing skill, check:

| Category | Check |
|----------|-------|
| **Frontmatter** | Has `name` and `description`; description uses third-person |
| **Trigger clarity** | Description clearly states when the skill activates |
| **Writing style** | Uses imperative form throughout; no "you should" language |
| **Context efficiency** | SKILL.md < 5k words; large tables/schemas in `references/` |
| **No duplication** | Information not repeated between SKILL.md and references |
| **Resource references** | All bundled files are mentioned in SKILL.md |
| **Scope focus** | Skill does one thing well; no unrelated instructions |
| **Output format** | Clear expected output format when applicable |
