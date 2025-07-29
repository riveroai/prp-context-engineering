# PRP Framework Project Onboarding Guide (v2.0)

## What's New in v2.0
- **Technology-specific templates** - Start with proven CLAUDE.md templates
- **ULTRATHINK methodology** - 5-step planning process before execution
- **5-level validation gates** - Progressive validation for quality
- **Parallel approaches** - Experimental commands for faster research
- **Context window management** - Critical new instance rule
- **Real-world metrics** - 1-2 hour autonomous runs, 300+ tests
- **Author insights** - Direct quotes and proven practices
- **Continuous improvement** - Evolution tracking and metrics

*Based on deep analysis of the PRP framework and real-world implementation experience*

## Overview
This guide outlines the battle-tested process for integrating a new project with the PRP (Product Requirement Prompt) context engineering framework to enable AI-assisted development with production-ready results in a single pass.

## Prerequisites
- [ ] Project concept or idea
- [ ] Draft PRD (Product Requirements Document) with sections
- [ ] Clone of [prp-context-engineering](https://github.com/riveroai/prp-context-engineering) repository
- [ ] Clear technology preferences
- [ ] Understanding of "Context is King" philosophy
- [ ] Review "PRP Framework Deep Analysis" document (optional but recommended)

## Phase 1: Framework Understanding

### 1.1 Study the PRP Framework
Before starting, understand the core concepts:

**PRP Formula**: `PRP = PRD + curated codebase intelligence + agent/runbook`

**Key Principles**:
- **Context is King** - Comprehensive context enables one-pass success
- **Progressive validation** - Validate at each level (5 levels)
- **ULTRATHINK methodology** - Plan comprehensively before execution
- **Pattern recognition** - AI mirrors codebase quality

**Author's Key Insights**:
> "In a large mature codebase you have existing patterns. If your codebase has good structure, is modular, is easy to read, your AI assistant is going to do extremely well."

- Built for **existing, mature codebases** (not greenfield)
- **Preparation is everything** - More upfront work = better results
- **Validation enables autonomy** - Multiple ways to validate = higher success
- **Context window hygiene** - New instance between create/execute

**Framework Architecture**:
```
prp-context-engineering/
├── CLAUDE.md              # Base framework rules
├── PRPs/              
│   ├── templates/         # PRP templates (base, planning, spec)
│   ├── ai_docs/           # Curated documentation
│   └── scripts/           # PRP runner (interactive/headless)
├── .claude/commands/      # 28+ Claude commands
│   ├── PRPs/              # Core creation/execution
│   ├── development/       # Utilities
│   ├── rapid-development/experimental/  # Parallel approaches
│   └── git-operations/    # Smart git ops
└── claude_md_files/       # Technology-specific templates

### 1.2 Understand the Separation of Concerns

| Component | Purpose | Contains |
|-----------|---------|----------|
| **CLAUDE.md** | Permanent project rules | Tech stack, principles, structure |
| **PRPs** | Feature implementations | Specific context, implementation details |
| **ai_docs/** | Documentation library | API docs, library guides |

## Phase 2: Project Analysis

### 2.1 PRD Preparation
Your PRD should include:
- [ ] Clear purpose/vision
- [ ] Functional requirements with sections
- [ ] Wireframes or UI mockups
- [ ] Technical requirements
- [ ] MVP scope definition
- [ ] Exclusions/future considerations

**PRD Template Structure**:
```markdown
# Product Name

## 1. Purpose
[What problem does it solve]

## 2. Functional Requirements
### 2.1 Feature Area 1
- Core features
- UX references

### 2.2 Feature Area 2
...

## 3. Non-Functional Requirements
- Performance
- Security
- Scalability

## 4. Wireframes
- Wireframe 01: [Description]
- Wireframe 02: [Description]

## 5. MVP Scope
- Included features
- Excluded features
```

### 2.2 Technology Decision Matrix

Before creating CLAUDE.md additions, decide:

| Decision | Questions to Answer |
|----------|-------------------|
| **Framework** | React? Next.js? Astro? Vue? |
| **UI Library** | shadcn/ui? MUI? Custom? |
| **State Management** | TanStack Query? Zustand? Redux? |
| **Styling** | Tailwind? CSS Modules? Styled Components? |
| **Database** | PostgreSQL? MongoDB? SQLite? |
| **Language** | TypeScript? JavaScript? |
| **Special Libraries** | Charts? Maps? Rich editors? |

## Phase 3: CLAUDE.md Creation

### 3.1 Select Base Template
Instead of starting from scratch, choose the appropriate technology template:

```
claude_md_files/
├── CLAUDE-ASTRO.md        # For Astro projects
├── CLAUDE-NEXTJS-15.md    # For Next.js 15+ projects
├── CLAUDE-NODE.md         # For Node.js backends
├── CLAUDE-PYTHON.md       # For Python projects
└── CLAUDE-REACT.md        # For React SPAs
```

### 3.2 Integrate Framework Patterns

Add these critical sections from the PRP framework:

**Required Framework Sections**:
```markdown
## Context Engineering Philosophy
- Context determines success
- Patterns guide implementation
- Validation enables autonomy
- Progressive enhancement

## AI Assistant Guidelines
### Search Command Requirements
**CRITICAL**: Always use `rg` (ripgrep) instead of `grep`

### Workflow Patterns
- Create comprehensive plan with TodoWrite
- Break complex tasks into validation checkpoints
- Test each component as you build

## ULTRATHINK Methodology
1. Analyze - Review all related code
2. Plan - Create comprehensive breakdown
3. Validate - Check against patterns
4. Execute - Implement with validation
5. Verify - Run all validation gates

## Progressive Validation Gates
### Level 1: Syntax & Linting
### Level 2: Unit Tests  
### Level 3: Integration Tests
### Level 4: E2E Tests
### Level 5: Deployment Validation

## PRP Methodology
- When to use PRPs
- Context requirements
- Execution best practices
```

### 3.3 Add Project-Specific Sections

**Required Additions Template**:
```markdown
## Project Nature
[Brief description of what your project is]

## Technology Stack
### Core Stack
- **Framework**: [Your choice with version]
- **UI Components**: [Library choice]
- **State Management**: [Approach]
- **Database**: [If applicable]

### Language Requirements
- [TypeScript/JavaScript rules]

## Project Structure
[Your specific directory structure]

## Development Constraints
### Component Rules
- [Size limits, patterns]

### API Patterns
- [Validation, error handling]

### [Project-Specific Patterns]
- [Your unique requirements]

## MVP Scope
### Included in MVP
- [List of features]

### Explicitly Excluded from MVP
- [What not to build yet]

## Project-Specific Anti-Patterns
- ❌ [What to avoid]
- ❌ [Common mistakes]
```

### 3.3 Common Pitfalls to Avoid

**DON'T Include**:
- ❌ Detailed implementation code
- ❌ Feature-specific logic
- ❌ API documentation
- ❌ Library usage examples

**DO Include**:
- ✅ Technology choices
- ✅ Project constraints
- ✅ MVP boundaries
- ✅ Development principles

## Phase 4: PRP Argument Generation

### 4.1 Argument Strategy

**Critical Requirements**:
- **MUST reference PRD file explicitly** with sections
- **MUST specify technology stack**
- **MUST include constraints** (e.g., "No TypeScript")
- **MUST reference wireframes** if applicable

**Incremental Approach** (Recommended):
1. Start with core UI/dashboard
2. Add data layer
3. Integrate external services
4. Add advanced features

### 4.2 Argument Template

```
/prp-base-create [Feature description] based on [prd-filename.md] sections [X.X-X.X]. 
Implement [specific components/features]. 
Reference wireframe [XX] from [prd-filename.md] for [UI element]. 
Stack: [technologies]. 
[Constraints like "No TypeScript"].
```

### 4.3 Argument Examples

```markdown
# Good Example (includes PRD reference)
/prp-base-create Build allocation dashboard based on headcount-prd.md sections 2.1-2.5. Implement engineer roster, allocation bars, inline editing. Reference wireframe 02 for table layout. Stack: Next.js, shadcn/ui, TanStack Query. No TypeScript.

# Bad Example (missing critical context)
/prp-base-create Build allocation dashboard with bars and editing
```

### 4.3 Argument Checklist

Each argument should specify:
- [ ] PRD file reference with sections
- [ ] Specific features to build
- [ ] Wireframe references if applicable
- [ ] Technology stack elements
- [ ] Constraints (e.g., "No TypeScript")
- [ ] What's NOT included (to prevent scope creep)

### 4.4 Example Progression

```markdown
# Option 1: Core Dashboard
/prp-base-create Build [Product] dashboard based on [prd].md sections 2.1-2.3...

# Option 2: Data Layer
/prp-base-create Implement data persistence for [Product] per [prd].md section 3...

# Option 3: External Integration
/prp-base-create Add [external service] integration following [prd].md section 4...
```

## Phase 5: Advanced PRP Techniques

### 5.1 Parallel Approaches (Experimental)

For complex features, leverage parallel agents:

#### Planning Parallel
```bash
/create-planning-parallel [idea]
# Deploys 4 agents: Market, Technical, UX, Compliance
# Creates PRD 4x faster with multiple perspectives
```

#### Base PRP Parallel
```bash
/create-base-prp-parallel [feature]
# 4 research agents work simultaneously:
# - Codebase patterns
# - Technical documentation
# - Testing strategies
# - Project documentation
```

#### Multiple Implementation Strategies
```bash
/parallel-prp-creation [feature] [details] [3]
# Creates 3 PRP variations:
# - Performance-optimized
# - Security-first  
# - Rapid-development
```

### 5.2 Execution Modes

```bash
# Interactive (development)
uv run PRPs/scripts/prp_runner.py --prp [name] --interactive

# Headless (CI/CD)
uv run PRPs/scripts/prp_runner.py --prp [name] --output-format json

# Streaming (monitoring)
uv run PRPs/scripts/prp_runner.py --prp [name] --output-format stream-json
```

### 5.3 Multi-Context Window Strategy

For large PRPs that span multiple context windows:
- Framework handles re-referencing automatically
- Can handle 2-3 windows typically (5 experimentally)
- Monitor execution for context switches
- Provide guidance at transition points

### 5.4 Critical Execution Rules

**MUST Follow**:
1. **New Claude instance** between create and execute (prevents hallucinations)
2. **Review PRP** before execution (check data models, tree structure)
3. **Monitor execution** for the first 10-15 minutes
4. **Provide corrections** in real-time (e.g., "use uv add not pip")
5. **Let it run** - 1-2 hour executions are normal for complex features

## Phase 6: Validation & Iteration

### 5.1 Audit Generated PRP

After running `/prp-base-create`, check:
- [ ] Context completeness
- [ ] Clear implementation blueprint
- [ ] Executable validation gates
- [ ] No missing requirements

### 5.2 Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Missing context | Add to ai_docs/ and reference |
| Vague requirements | Update PRD with specifics |
| Over-engineering | Reduce scope in argument |
| Missing validation | Add test commands |

### 5.3 Next PRP Decision Tree

```
Start
  │
  ├─ Core UI Working?
  │   ├─ No → Fix with targeted PRP
  │   └─ Yes ↓
  │
  ├─ Data Persistence?
  │   ├─ No → Create data layer PRP
  │   └─ Yes ↓
  │
  ├─ External Integrations?
  │   ├─ No → Add integration PRPs
  │   └─ Yes ↓
  │
  └─ Advanced Features
```

## Phase 6: Project Structure Setup

### 6.1 Initial Directory Structure
```bash
your-project/
├── .claude/
│   └── commands/        # Copy from prp-context-engineering
├── PRPs/                # Your project PRPs
│   └── completed/       # Move completed PRPs here
├── ai_docs/             # Your curated docs
├── CLAUDE.md            # Your crafted rules
├── [project-name]-prd.md # Your PRD
└── src/                 # Your code
```

### 6.2 Development Workflow Setup

**Author's Setup** (for complex projects):
- **4 terminal windows** - Parallel Claude sessions
- **Separate IDE** - Core development work
- **Monitor long runs** - 1-2 hour autonomous executions

**Basic Setup** (recommended start):
- 1 Claude terminal for PRP execution
- 1 IDE for review and manual fixes
- Git for version control between runs

### 6.2 Documentation Curation

For `ai_docs/`, include:
- API documentation for external services
- Library documentation for complex dependencies
- Project-specific patterns and examples
- Migration guides if refactoring

## Success Metrics

Your project is properly onboarded when:
- [ ] CLAUDE.md integrates framework patterns with project rules
- [ ] PRD is comprehensive with numbered sections and wireframes
- [ ] PRP arguments reference PRD sections explicitly
- [ ] ai_docs/ contains curated library documentation
- [ ] First PRP generates working code with minimal fixes
- [ ] Validation gates catch issues at each level
- [ ] Context window management understood (new instance rule)

## Real-World Example: HeadcountSync Case Study

**Starting Point**: 
- Idea: Team allocation management tool
- Draft PRD with wireframes and 7 sections
- Preference for Next.js and modern stack

**Process**:
1. **Analyzed PRD** - Identified sections 2.1-2.6 as core features
2. **Selected base template** - Started with CLAUDE-NEXTJS-15.md
3. **Integrated PRP patterns** - Added validation gates, ULTRATHINK
4. **Created CLAUDE.md** - Balanced framework methodology with project rules
5. **Generated PRP arguments** - Explicitly referenced PRD sections
6. **Validated approach** - Caught kibo-ui wasn't needed for table view

**Key Insights**:
- Technology-specific templates provide solid foundation
- Framework patterns enhance but don't replace project rules
- Explicit PRD references crucial for context
- Validation gates enable autonomous execution

**Result**: 
- Clear separation of concerns
- Focused MVP scope
- Executable first PRP with validation
- Expected 1-2 hour autonomous execution

## Common Pitfalls & Solutions

| Pitfall | Solution |
|---------|----------|
| Mixing framework rules with project specifics | Keep CLAUDE.md focused on project, PRPs handle methodology |
| Vague PRP arguments | Always reference PRD sections explicitly |
| No ai_docs/ curation | Add key library docs before PRP execution |
| Same context window for create/execute | ALWAYS use new Claude instance |
| Over-specifying in CLAUDE.md | Let PRPs handle implementation details |

## Quick Reference Checklist

```markdown
## New Project Onboarding Checklist

### Preparation
- [ ] Draft PRD with numbered sections
- [ ] Include wireframes in PRD
- [ ] Technology decisions made
- [ ] MVP scope clearly defined

### Framework Setup
- [ ] Clone prp-context-engineering
- [ ] Study framework patterns
- [ ] Understand ULTRATHINK methodology
- [ ] Review experimental commands

### Project Configuration
- [ ] Select technology-specific CLAUDE.md template
- [ ] Integrate PRP framework patterns
- [ ] Add project-specific rules
- [ ] Create ai_docs/ with library documentation

### PRP Creation
- [ ] Write argument with PRD references
- [ ] Include technology stack
- [ ] Specify constraints clearly
- [ ] Run /prp-base-create

### Execution
- [ ] Review generated PRP thoroughly
- [ ] Open NEW Claude instance
- [ ] Run /prp-base-execute
- [ ] Monitor validation gates

### Success Indicators
- [ ] Code runs on first try
- [ ] All validation gates pass (5 levels)
- [ ] Test coverage >80%
- [ ] Ready for next feature
```

## Phase 7: Continuous Improvement

### 7.1 CLAUDE.md Evolution
As your project matures:
- Add project-specific patterns discovered
- Document gotchas and edge cases
- Update validation commands
- Refine anti-patterns based on experience

### 7.2 PRP Template Refinement
After each major feature:
- Review what worked well
- Identify missing context
- Update ai_docs/ with new findings
- Share learnings with team

### 7.3 Metrics Tracking
Monitor for improvement:
- Autonomous execution time
- Manual intervention frequency
- Test generation quality
- Validation gate success rate

**Target Evolution**:
- Week 1: 60% autonomous success
- Month 1: 80% autonomous success
- Month 3: 95% autonomous success

---

**Remember**: The goal is one-pass implementation success through comprehensive context.

## Templates and Resources

All project templates are now organized in:
- **Templates**: `/docs/templates/`
- **Master Guide**: `/docs/master-guide.md`
- **Examples**: See HeadcountSync in `/forge/examples/`

Start with the [Master Guide](./master-guide.md) for a complete overview of all resources. The PRP framework provides the methodology, your CLAUDE.md provides the rules, and together they enable autonomous AI development.

**Critical Success Factor**: Context is King - more context = better results.