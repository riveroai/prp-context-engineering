# 🚀 PRP Framework Quick Start Prompt

Copy and customize this all-in-one prompt for new projects:

---

## The Master Prompt

I want to build a new project using the PRP framework with context engineering. Help me set up everything properly.

### 🎯 Project Overview

**Name**: [YourProjectName]
**Description**: [One paragraph about what it does and who uses it]

**Similar to**: [Existing product/tool if applicable]
**Key difference**: [What makes yours unique]

### 📋 Core Features (Priority Order)

**MVP Must-Haves**:
1. [Feature 1 - most important]
2. [Feature 2]
3. [Feature 3]

**Nice-to-Haves** (post-MVP):
- [Feature 4]
- [Feature 5]

**Future Vision**:
- [Feature 6]

### 🔌 Integrations

**External Services**: [Jira/Slack/GitHub/None]
- **Access**: [Read-only / Read-write]
- **Auth**: [OAuth / API Key / Webhook]

### 💻 Technical Preferences

```yaml
Stack:
  Framework: [Next.js 15 / React / FastAPI / "recommend best"]
  Language: [TypeScript / JavaScript / Python / "recommend best"]
  Database: [PostgreSQL / MongoDB / "recommend best"]
  UI: [shadcn/ui / MUI / Tailwind only / "recommend best"]
  
Standards:
  Testing: [High coverage / Moderate / Minimal]
  TypeScript: [Strict / Pragmatic / No TypeScript]
  Documentation: [Comprehensive / Essential / Minimal]
```

### 👥 Context

- **Team**: [Solo / Small team / Large team]
- **Timeline**: [ASAP / 1 month / 3 months]
- **Scale**: [10 users / 100s / 1000s]
- **Environment**: [Startup / Enterprise / Personal]

### 🎨 UI/UX

**Style**: [Clean minimal / Corporate / Modern SaaS / Playful]
**Inspiration**: [Linear.app / Notion / Stripe / Other: ___]
**Key UX**: [Data tables / Dashboards / Forms / Charts / Other: ___]

### ❓ Specific Questions

1. [Technical question about architecture]
2. [Question about best practices]
3. [Question about specific integration]

---

## 📝 What I Need From You

Please provide in this order:

### 1. Project Analysis
- Clarifying questions if needed
- Recommendations for any "recommend best" items
- Potential challenges to consider

### 2. CLAUDE.md Generation
- Complete CLAUDE.md following framework patterns
- Adapted for my tech stack
- Including all sections from CLAUDE-NEXTJS-15.md

### 3. PRP Commands
```bash
# Planning command (with my specifics):
/create-planning-parallel ...

# Implementation command (after PRD):
/create-base-prp-parallel ...

# Alternative approaches if applicable:
/parallel-prp-creation ...
```

### 4. Project Setup
```bash
# Initial setup commands
# Required ai_docs/ files
# Devcontainer customization if using Forge
```

### 5. Execution Roadmap
- Phase 1: [What to do first]
- Phase 2: [What to do next]
- Phase 3: [And so on]

### 6. Success Metrics
- How to know MVP is complete
- Quality gates to monitor
- Performance targets

---

## 🚀 Quick Mode

If I just want to start coding ASAP, give me:
1. The fastest path to working code
2. What can be figured out later
3. Minimum viable CLAUDE.md
4. Single PRP command to start

---

## 🎯 Example Fill

Here's a quick example:

**Name**: TeamSync
**Description**: Slack-integrated daily standup tool that automatically collects updates from team members and generates summary reports.

**MVP Must-Haves**:
1. Slack bot that messages team members
2. Web dashboard showing collected updates  
3. Automated summary generation

**Stack**: Next.js 15 / TypeScript / PostgreSQL / shadcn/ui
**Timeline**: 2 weeks
**Scale**: 50 users

[Rest of template...]
