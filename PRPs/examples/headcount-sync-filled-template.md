# HeadcountSync - Filled Template Example

This is a real example of how to fill the Project Initialization Template for HeadcountSync.

## 🎯 Project Overview

**Project Name**: HeadcountSync

**One-Line Description**: Engineering headcount and allocation management tool that visualizes team workload across projects with Jira integration

**Project Type**: [X] Internal Tool

## 📋 Core Requirements

### Business Context
- **Primary Users**: Engineering managers and team leads
- **Key Problem**: Managers struggle to visualize team allocations across projects, leading to over/under-utilized engineers
- **Success Metrics**: 80% manager adoption, 2+ hours saved per week, 90% allocation accuracy
- **User Count**: 10-50 engineers across teams

### Functional Requirements (Priority Order)
1. **Must Have (MVP)**:
   - Engineer roster with capacity tracking (FTE/contractor distinction)
   - Project allocation visualization (horizontal bars with percentages)
   - Jira sync for real-time workload data
   - Inline allocation editing with validation
   - Weekly view with filters
   - CSV export functionality

2. **Should Have (Post-MVP)**:
   - Monthly view with trends
   - Historical allocation tracking
   - Email notifications for overallocation
   - SSO authentication
   - Bulk editing capabilities

3. **Could Have (Future)**:
   - Gantt chart view
   - Forecasting/planning mode
   - Jira write-back
   - Slack integration

### External Integrations
- **Primary Integration**: Jira Cloud
  - Access Type: Read-only
  - Auth Method: PAT (Personal Access Token)
  - Key Operations: Fetch active issues, assignees, labels/epics for project mapping

## 🏗️ Technical Specifications

### Technology Stack Preferences
```yaml
Frontend:
  Framework: Next.js 15
  Language: TypeScript (strict mode)
  UI Library: shadcn/ui only
  State Management: TanStack Query (server state), Zustand (UI state)

Backend:
  Runtime: Node.js (via Next.js)
  API Style: REST (Next.js API routes)
  Database: PostgreSQL
  ORM/Query Builder: Prisma

Authentication:
  Provider: NextAuth.js
  Methods: Email (MVP), SSO ready

Infrastructure:
  Hosting: Vercel (cloud-first)
  CI/CD: GitHub Actions
```

### Data Model Overview
```
Main Entities:
1. Engineer
   - Key fields: id, email, name, role, capacity, isContractor, status
   - Relationships: Has many Allocations

2. Project
   - Key fields: id, name, jiraKey, color, status
   - Relationships: Has many Allocations

3. Allocation
   - Key fields: engineerId, projectId, percentage, weekStart, isManual
   - Relationships: Belongs to Engineer and Project

4. JiraSync
   - Key fields: status, message, startedAt, completedAt
   - Relationships: Audit log for sync operations
```

### Specific Constraints
- **Performance**: Handle 100+ engineers without lag
- **Security**: Email/password auth, audit logs required
- **Scale**: 10-50 engineers initially
- **Browser Support**: Modern browsers only (Chrome 90+, Firefox 90+, Safari 14+)
- **Mobile**: Responsive web (read-only on mobile fine)

## 🎨 UI/UX Requirements

### Design Preferences
- **Style**: Modern Minimal / Clean corporate
- **Color Scheme**: Light theme, with color-coded allocation bars
- **Key UI Elements**: 
  - [X] Dashboard with metrics
  - [X] Data tables with sorting/filtering
  - [X] Inline editing forms
  - [X] Horizontal bar visualizations

### Example UI References
- **Similar Products**: Linear (table design), Toggl Plan (allocation bars)
- **Specific Features to Emulate**: Inline editing, real-time updates, clean data density

## 📊 Sample Use Case

**User Story Example**:
"As an engineering manager, I want to see my team's current project allocations at a glance so that I can identify who is overloaded or has capacity"

**Concrete Scenario**:
Monday morning, Sarah (Engineering Manager) opens HeadcountSync. She immediately sees that John is allocated 140% (red indicator) across 3 projects, while Emma is at 60% (yellow). She clicks on John's allocation bar, reduces his Project C commitment from 60% to 40%, and reassigns 20% to Emma. The changes save automatically with an audit trail.

## 🚀 Development Approach

### Preferred Methodology
- [X] Start with comprehensive PRD (Planning first)
- [X] Parallel development (Multiple features at once)

### Team Context
- **Solo Developer** with AI assistance
- **Timeline**: MVP in 1-2 weeks
- **Budget Constraints**: Minimal (use existing tools/services)

## 📝 Additional Context

### Known Challenges
- Jira field mapping varies by organization
- Part-time contractor capacity calculations
- Handling engineers across multiple teams
- Weekly vs sprint-based allocation views

### Questions for AI
1. Best approach for Jira field mapping UI?
2. How to handle allocation history efficiently?
3. Optimal caching strategy for Jira data?

---

## 🎯 Resulting Commands

After filling this template, the generated commands were:

```bash
# 1. Generate comprehensive PRD
/create-planning-parallel HeadcountSync - engineering allocation management tool with Jira Cloud integration for tracking team workload. Features: engineer roster (FTE/contractor), allocation bars, PAT-based Jira sync, inline editing, weekly view, filters, CSV export. Tech: Next.js 15, TypeScript, PostgreSQL, Prisma, NextAuth, shadcn/ui. Scale: 10-50 engineers, read-only Jira, audit logs required.

# 2. Generate CLAUDE.md
# (Custom CLAUDE.md was created based on the tech stack and requirements)

# 3. Generate implementation PRP
/create-base-prp-parallel HeadcountSync MVP based on headcount-prd.md. Stack: Next.js 15, TypeScript, PostgreSQL, Prisma, NextAuth.js, shadcn/ui, TanStack Query. Include engineer CRUD, allocation visualization, Jira sync engine, inline editing, filters, audit logs.

# 4. Execute PRP (in new terminal!)
/prp-base-execute PRPs/headcount-data-foundation.md
```
