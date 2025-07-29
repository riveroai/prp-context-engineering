# 🎯 PRP Framework Master Guide - Complete Toolkit

This guide organizes all templates and documentation for the PRP Framework workflow in logical order.

## 📚 Table of Contents

1. [Understanding the Framework](#1-understanding-the-framework)
2. [Starting a New Project](#2-starting-a-new-project)
3. [Returning to Existing Projects](#3-returning-to-existing-projects)
4. [Quick Reference](#4-quick-reference)
5. [Examples & Case Studies](#5-examples--case-studies)

---

## 1. Understanding the Framework

### Core Concepts
- **CLAUDE.md** = Development philosophy and patterns (HOW to build)
- **PRD** = Product requirements and features (WHAT to build)
- **PRPs** = Implementation prompts with context (EXECUTION plans)

### Key Principles
- Context is King
- Validation Enables Autonomy
- Progressive Enhancement
- Parallel Execution for Speed

### Essential Reading
📖 **[Step-by-Step Onboarding Guide](./guide.md)** - Detailed phases for new projects  
📖 **[Framework Deep Analysis](./deep.md)** - Technical internals and advanced techniques

### Framework Structure
```
prp-context-engineering/
├── .claude/commands/        # 28+ pre-built commands
├── PRPs/                    # Your project PRPs
│   ├── templates/          # PRP templates
│   └── ai_docs/            # Curated documentation
├── claude_md_files/        # Technology-specific CLAUDE.md examples
└── docs/                   # Framework documentation
    └── templates/          # Project templates (this directory)
```

---

## 2. Starting a New Project

Choose your path based on project needs:

### 🎯 Path A: Comprehensive Planning (Recommended)

**When to use**: New projects, unclear requirements, team collaboration

#### Step 1: Fill Project Template
📄 **[Project Initialization Template](./templates/project-initialization-template.md)**
- Comprehensive questionnaire
- Covers all aspects of project
- Takes 30-45 minutes to fill

#### Step 2: Generate CLAUDE.md
📄 **[CLAUDE.md Generation Template](./templates/claude-md-generation-template.md)**
- Creates development guidelines
- Adapts to your tech stack
- Establishes coding standards

#### Step 3: Generate PRD with Planning
```bash
# Use the planning command from filled template
/create-planning-parallel [your project details]
```

#### Step 4: Generate Implementation PRP
```bash
# After PRD is complete
/create-base-prp-parallel [project] based on [prd-name].md
```

### ⚡ Path B: Quick Start

**When to use**: Clear requirements, familiar domain, need speed

#### Use All-in-One Template
📄 **[Quick Start Template](./templates/quick-start-template.md)**
- Single prompt for everything
- Generates CLAUDE.md + commands
- 15-20 minutes to code

### 🏃 Path C: Speed Run

**When to use**: Experienced users, hackathons, prototypes

#### Use Minimal Template
📄 **[Speed Run Template](./templates/speed-run-template.md)**
- Ultra-concise format
- Pre-filled examples
- 5 minutes to start

---

## 3. Returning to Existing Projects

### Context Refresh Workflow

#### Use Return Template
📄 **[Returning to Project Template](./templates/returning-to-project-template.md)**
- Refreshes context efficiently
- Generates next steps
- Handles project evolution

---

## 4. Quick Reference

### 📋 Template Selection
📄 **[Template Selection Guide](./templates/template-selection-guide.md)**
- Decision matrix
- Time estimates
- Success metrics

### 🚀 Key Commands

#### Planning Commands
```bash
# Comprehensive planning (4 parallel agents)
/create-planning-parallel [description]

# Standard planning
/prp-planning-create [description]
```

#### Implementation Commands
```bash
# Parallel research implementation
/create-base-prp-parallel [project] based on [prd].md

# Standard implementation
/prp-base-create Build [project] following [prd].md

# Multiple approach comparison
/parallel-prp-creation [feature] "[details]" 3
```

#### Execution Commands
```bash
# Interactive execution
/prp-base-execute PRPs/[name].md

# Headless execution (in container)
uv run PRPs/scripts/prp_runner.py --prp [name] --output-format json
```

### 📁 Project Structure Best Practice

```
your-project/
├── CLAUDE.md              # Development guidelines
├── project-prd.md         # Product requirements
├── project-brief.md       # Your filled template
├── PRPs/                  # Implementation prompts
│   ├── completed/         # Finished PRPs
│   └── in-progress/       # Current work
├── ai_docs/               # Curated documentation
└── src/                   # Your code
```

---

## 5. Examples & Case Studies

### HeadcountSync Example

**Project**: Engineering allocation management tool with Jira integration

#### Files Created:
1. **CLAUDE.md** - Development rules specific to HeadcountSync
2. **headcount-prd.md** - Complete product requirements
3. **PRPs/** - Implementation prompts for each feature

#### Implementation Flow:
```bash
# 1. Generated PRD with parallel planning
/create-planning-parallel HeadcountSync - engineering allocation tool...

# 2. Created base PRP with research
/create-base-prp-parallel HeadcountSync MVP based on headcount-prd.md...

# 3. Executed in new terminal
/prp-base-execute PRPs/headcount-data-foundation.md
```

### Standard Workflow Example

```bash
# 1. Fill comprehensive template
# Copy from: docs/templates/project-initialization-template.md

# 2. Submit to Claude with this prompt:
"I want to develop a new project using PRP framework. Here's my filled template:
[PASTE TEMPLATE]
Please generate CLAUDE.md and all necessary commands."

# 3. Execute planning command
/create-planning-parallel [generated command]

# 4. Execute implementation command (NEW TERMINAL!)
/create-base-prp-parallel [generated command]

# 5. Execute the PRP (NEW TERMINAL!)
/prp-base-execute PRPs/[project-name].md
```

---

## 🚀 Pro Tips for Maximum Productivity

### 1. **Parallel Development**
Run multiple features simultaneously:
```bash
# Terminal 1: Backend
/prp-base-execute PRPs/backend.md

# Terminal 2: Frontend
/prp-base-execute PRPs/frontend.md

# Terminal 3: Tests
/prp-base-execute PRPs/tests.md
```

### 2. **Forge Container Setup**
For autonomous execution:
```bash
# In .devcontainer with tmux
claude --dangerously-skip-permissions

# Monitor with tmux windows
tmux attach-session -t forge
```

### 3. **Reuse Patterns**
- Save successful CLAUDE.md files
- Build library of common PRPs
- Create team templates

### 4. **Progressive Enhancement**
- Start with MVP
- Add features incrementally
- Validate at each step

### 5. **Time Estimates**
- Planning: 1-2 hours
- CLAUDE.md: 20 minutes
- PRP Creation: 30-60 minutes
- Execution: 1-2 hours autonomous
- **Total**: 3-5 hours to MVP

---

## 🎯 Success Checklist

Before starting any project:
- [ ] Selected appropriate template
- [ ] Filled all required sections
- [ ] Generated CLAUDE.md
- [ ] Created PRD (if comprehensive path)
- [ ] Have PRP commands ready
- [ ] Prepared ai_docs/ content
- [ ] Ready for NEW TERMINAL rule

---

## 📞 Additional Resources

### Documentation
- 📖 **[Onboarding Guide](./guide.md)** - Complete step-by-step process
- 📖 **[Deep Analysis](./deep.md)** - Framework internals and metrics
- 📄 **[All Templates](./templates/)** - Ready-to-use project templates

### External Links
- [PRP Framework GitHub](https://github.com/riveroai/prp-context-engineering)
- [Video Walkthrough](https://www.youtube.com/watch?v=KVOZ9s1S9Gk)

### Framework Files
- Commands: `.claude/commands/`
- CLAUDE.md Examples: `claude_md_files/`
- PRP Templates: `PRPs/templates/`

---

**Remember**: The goal is one-pass implementation success through comprehensive context. Choose your template, fill it completely, and let the framework handle the complexity!
