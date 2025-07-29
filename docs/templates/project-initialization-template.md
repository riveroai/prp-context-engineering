# PRP Framework Project Initialization Template

## 🎯 Project Overview

**Project Name**: [Your Project Name]

**One-Line Description**: [Brief description - what problem does it solve?]

**Project Type**: 
- [ ] Web Application (SaaS)
- [ ] Internal Tool
- [ ] API Service
- [ ] Mobile App
- [ ] Other: ___________

## 📋 Core Requirements

### Business Context
- **Primary Users**: [Who will use this? Roles/personas]
- **Key Problem**: [What specific problem are you solving?]
- **Success Metrics**: [How will you measure success?]
- **User Count**: [Expected scale - 10s, 100s, 1000s?]

### Functional Requirements (Priority Order)
1. **Must Have (MVP)**:
   - Feature 1: [Description]
   - Feature 2: [Description]
   - Feature 3: [Description]

2. **Should Have (Post-MVP)**:
   - Feature 4: [Description]
   - Feature 5: [Description]

3. **Could Have (Future)**:
   - Feature 6: [Description]

### External Integrations
- **Primary Integration**: [e.g., Jira, Slack, GitHub]
  - Access Type: [Read-only / Read-write]
  - Auth Method: [OAuth / API Key / PAT]
  - Key Operations: [List what you need to do]

- **Secondary Integrations**: [List any others]

## 🏗️ Technical Specifications

### Technology Stack Preferences
```yaml
Frontend:
  Framework: [Next.js 15 / React / Vue / Other]
  Language: [TypeScript / JavaScript]
  UI Library: [shadcn/ui / MUI / Tailwind only / Other]
  State Management: [TanStack Query / Zustand / Redux / Other]

Backend:
  Runtime: [Node.js / Python / Go / Other]
  API Style: [REST / GraphQL / tRPC]
  Database: [PostgreSQL / MySQL / MongoDB / Other]
  ORM/Query Builder: [Prisma / Drizzle / TypeORM / Other]

Authentication:
  Provider: [NextAuth.js / Clerk / Auth0 / Custom]
  Methods: [Email / OAuth / SSO / Other]

Infrastructure:
  Hosting: [Vercel / AWS / Docker / Other]
  CI/CD: [GitHub Actions / GitLab / Other]
```

### Data Model Overview
```
Main Entities:
1. [Entity Name] - [Brief description]
   - Key fields: [field1, field2]
   - Relationships: [Related to X]

2. [Entity Name] - [Brief description]
   - Key fields: [field1, field2]
   - Relationships: [Related to Y]
```

### Specific Constraints
- **Performance**: [Any specific requirements?]
- **Security**: [Compliance needs? GDPR, SOC2?]
- **Scale**: [Expected load, concurrent users?]
- **Browser Support**: [Modern only or legacy support?]
- **Mobile**: [Responsive web or native app?]

## 🎨 UI/UX Requirements

### Design Preferences
- **Style**: [Modern Minimal / Corporate / Playful / Other]
- **Color Scheme**: [Dark / Light / Both / Specific brand colors]
- **Key UI Elements**: 
  - [ ] Dashboard with metrics
  - [ ] Data tables with sorting/filtering
  - [ ] Forms with validation
  - [ ] Charts/visualizations
  - [ ] Other: ___________

### Example UI References
- **Similar Products**: [List products with good UX]
- **Specific Features to Emulate**: [What you like about them]

## 📊 Sample Use Case

**User Story Example**:
"As a [user type], I want to [action] so that [benefit]"

**Concrete Scenario**:
[Describe a real-world scenario of someone using your tool]

## 🚀 Development Approach

### Preferred Methodology
- [ ] Start with comprehensive PRD (Planning first)
- [ ] Jump to MVP implementation (Code first)
- [ ] Parallel development (Multiple features at once)
- [ ] Iterative prototyping

### Team Context
- **Solo Developer** / **Small Team** / **Large Team**
- **Timeline**: [ASAP / 1 month / 3 months / No rush]
- **Budget Constraints**: [Minimal / Moderate / Flexible]

## 📝 Additional Context

### Existing Resources
- **Similar Internal Tools**: [Any existing systems to reference?]
- **Design Assets**: [Mockups, wireframes, brand guides?]
- **API Documentation**: [Links to external API docs]
- **Example Data**: [Sample datasets available?]

### Known Challenges
- [Technical challenge 1]
- [Business challenge 2]
- [Integration challenge 3]

### Questions for AI
1. [Specific question about architecture]
2. [Specific question about implementation]
3. [Specific question about best practices]

---

## 🎯 Quick Start Commands

After filling out this template, use these commands:

### Step 1: Generate CLAUDE.md
First, establish your project's development philosophy and patterns based on your tech stack.

### Step 2: Generate PRD
```bash
# For comprehensive planning with parallel research:
/create-planning-parallel [Project Name] - [one-line description with key requirements from above]

# For simpler planning:
/prp-planning-create [Project Name] - [detailed description with all requirements]
```

### Step 3: Generate Implementation PRP
```bash
# With parallel research for complex projects:
/create-base-prp-parallel [Project Name] MVP based on [prd-name].md. Stack: [tech]. Focus: [key features].

# For standard implementation:
/prp-base-create Build [Project Name] MVP following [prd-name].md sections X.X-X.X. Stack: [tech]. Reference wireframes.
```

## 📋 Checklist Before Starting

- [ ] All MVP features clearly defined
- [ ] Technology stack decided
- [ ] External integration details clear
- [ ] Data model sketched out
- [ ] UI/UX preferences stated
- [ ] Success metrics defined
- [ ] Timeline expectations set
