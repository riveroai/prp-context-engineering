# 🔄 Returning to PRP Project - Context Refresh Prompt

Use this when returning to an existing PRP framework project after a break.

---

## The Return Prompt

I'm returning to work on [PROJECT NAME] which uses the PRP framework. I need to refresh context and continue development efficiently.

### 📁 Project Files Present

**Existing files I have**:
- [ ] CLAUDE.md
- [ ] [project-name]-prd.md  
- [ ] PRPs/ folder with: [list completed PRPs]
- [ ] ai_docs/ with: [list docs]
- [ ] Source code in: [folder structure]

### 🏗️ Current State

**Completed Features**:
1. ✅ [Feature 1 - e.g., Database schema]
2. ✅ [Feature 2 - e.g., Authentication]
3. ✅ [Feature 3 - e.g., Basic UI]

**In Progress**:
- 🔄 [Feature being worked on]
- Branch: [branch name if applicable]
- Last task: [what was last done]

**Not Started**:
- ⭕ [Feature 4]
- ⭕ [Feature 5]

### 🚧 Known Issues

**Blockers**:
- [Issue 1 - e.g., Jira API rate limits]
- [Issue 2 - e.g., Performance with large datasets]

**Tech Debt**:
- [Area 1 needing refactor]
- [Area 2 with temporary solution]

### 📝 Changes Since Initial Plan

**New Requirements**:
- [New feature request from stakeholders]
- [Changed integration needs]

**Removed/Deprioritized**:
- [Feature that's no longer needed]

**Technical Decisions Made**:
- Chose [X] instead of [Y] because [reason]
- Decided to [approach] for [problem]

### 🎯 Current Sprint Goals

**This Week**:
1. [ ] Complete [specific feature]
2. [ ] Fix [specific bug]
3. [ ] Test [integration]

**Next Milestone**:
- Target: [date or event]
- Must have: [features needed]

---

## 🤝 What I Need

### 1. Context Refresh
- Quick summary of where the project stands
- Remind me of key architectural decisions
- Flag any patterns I should follow

### 2. Next PRP Commands
Based on current state, provide:
```bash
# Continue current feature:
/prp-base-create ...

# Or start next feature:
/create-base-prp-parallel ...

# Or fix technical debt:
/prp-spec-create Transform [old pattern] to [new pattern]...
```

### 3. Parallel Execution Strategy
If multiple features can be worked on simultaneously:
```bash
# Terminal 1:
/prp-base-execute PRPs/[feature1].md

# Terminal 2:  
/prp-base-execute PRPs/[feature2].md
```

### 4. Updated Roadmap
- Updated phase plan based on current progress
- Realistic timeline adjustments
- Risk mitigation for blockers

### 5. Quick Wins
Identify 2-3 small tasks I can complete quickly to build momentum

---

## 🚀 Rapid Re-engagement Options

### Option A: Continue Exactly Where I Left Off
"Just tell me the next command to run"

### Option B: Strategic Pivot
"Given what's done, should we adjust the approach?"

### Option C: Cleanup First
"What technical debt should we address before adding features?"

### Option D: Parallel Sprint
"What can be built simultaneously to accelerate?"

---

## 📋 Validation Checklist

Before continuing, verify:
- [ ] All tests still pass
- [ ] TypeScript compiles
- [ ] Database migrations are current
- [ ] No security vulnerabilities
- [ ] Documentation is updated

---

## 💡 Additional Context

[Paste any relevant context like stakeholder feedback, error logs, performance metrics, etc.]

### Recent Learnings
- [Thing that worked well]
- [Thing that didn't work]
- [Pattern discovered]

### Questions
1. [Specific technical question]
2. [Architecture decision needed]
3. [Best practice question]
