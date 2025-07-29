# 🎯 PRP Framework Templates - Quick Selection Guide

## 📖 Before You Start

**New to PRP Framework?** Read these first:
1. 📖 **[Onboarding Guide](../guide.md)** - Step-by-step process for new projects
2. 📖 **[Deep Analysis](../deep.md)** - Understanding framework internals
3. 📖 **[Master Guide](../master-guide.md)** - Complete overview with links

## Choose Your Starting Point

### 🆕 Starting a New Project

#### Option 1: Comprehensive Planning (Recommended)
**Use**: [Project Initialization Template](./project-initialization-template.md)
- **When**: You want thorough planning and research
- **Time**: 2-3 hours setup, saves days later
- **Result**: Complete PRD, CLAUDE.md, and execution plan

#### Option 2: Quick Start
**Use**: [Quick Start Template](./quick-start-template.md)
- **When**: You know what you want and need fast setup
- **Time**: 30 minutes to working code
- **Result**: Minimal viable setup + PRP commands

#### Option 3: Speed Run
**Use**: [Speed Run Template](./speed-run-template.md)
- **When**: Experienced with PRP, just need commands
- **Time**: 5 minutes to start coding
- **Result**: PRP commands ready to execute

### 🔄 Returning to Existing Project

**Use**: [Returning to Project Template](./returning-to-project-template.md)
- **When**: Continuing work after a break
- **Time**: 15 minutes to full context
- **Result**: Next steps + updated roadmap

### 🎨 Need Custom CLAUDE.md

**Use**: [CLAUDE.md Generation Template](./claude-md-generation-template.md)
- **When**: Non-standard tech stack or special requirements
- **Time**: 20 minutes
- **Result**: Tailored CLAUDE.md for your stack

## 📊 Decision Matrix

| Scenario | Template | Speed | Thoroughness |
|----------|----------|-------|--------------|
| Greenfield with time | Comprehensive | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Know requirements | Quick Start | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Built similar before | Speed Run | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| Hackathon/MVP | Speed Run Hackathon | ⭐⭐⭐⭐⭐ | ⭐ |
| Complex enterprise | Comprehensive | ⭐⭐ | ⭐⭐⭐⭐⭐ |

## 🚀 Command Progression

### Standard Flow
```bash
# 1. Generate PRD
/create-planning-parallel [project description]

# 2. Generate implementation PRP
/create-base-prp-parallel [project] based on [prd].md

# 3. Execute PRP (new terminal!)
/prp-base-execute PRPs/[project].md
```

### Speed Flow
```bash
# Skip PRD, straight to implementation
/prp-base-create Build [project] MVP with [features]. Stack: [tech].

# Execute immediately
/prp-base-execute PRPs/[project].md
```

### Parallel Flow
```bash
# Generate multiple approaches
/parallel-prp-creation [feature] "[requirements]" 3

# Compare and choose best approach
# Then execute selected PRP
```

## 💡 Pro Workflow Tips

### 1. Stack Selection
If unsure about tech choices, use:
- **"recommend best"** in templates
- **Similar to [X]** for reference
- **Framework defaults** (e.g., Next.js → TypeScript, Tailwind, Prisma)

### 2. Feature Prioritization
- **MVP**: 3-5 core features max
- **Post-MVP**: 3-5 more features
- **Future**: Everything else

### 3. Time Estimation
- **Planning PRP**: 1-2 hours
- **Base PRP Creation**: 30-60 minutes
- **PRP Execution**: 1-2 hours autonomous
- **Total to MVP**: 4-6 hours

### 4. Parallel Development
Run multiple terminals with:
```bash
# Terminal 1: Backend
/prp-base-execute PRPs/backend.md

# Terminal 2: Frontend  
/prp-base-execute PRPs/frontend.md

# Terminal 3: Integration
/prp-base-execute PRPs/integration.md
```

## 📁 Template Storage

Save your templates:
```bash
mkdir ~/prp-templates
cp [template].md ~/prp-templates/

# Your filled template
cp my-project-brief.md ~/projects/projectname/
```

## 🔄 Reusability Pattern

1. **Fill template once** → Save as `project-brief.md`
2. **Generate CLAUDE.md** → Reuse across similar projects
3. **Create PRP library** → Build collection of common PRPs
4. **Share with team** → Standardize approach

## 🎯 Success Metrics

You're using templates effectively when:
- ✅ Project setup takes <1 hour
- ✅ First working code in <4 hours  
- ✅ 80% autonomous execution
- ✅ Minimal manual fixes needed
- ✅ Can parallelize development

Remember: The templates are guides. Adapt them to your needs, but keep the core PRP principles:
- **Context is King**
- **Validation Enables Autonomy**
- **Progressive Enhancement**

Start with the template that matches your situation and iterate! 🚀
