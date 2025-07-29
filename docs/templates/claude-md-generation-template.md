# CLAUDE.md Generation Prompt Template

Use this template to generate a proper CLAUDE.md for your project that follows PRP framework patterns.

---

## The Prompt

I need to create a CLAUDE.md file for my project following the PRP framework patterns. Here are my project details:

### Project Context
- **Project Type**: [Web app / API service / CLI tool / etc.]
- **Development Approach**: [Greenfield / Refactoring existing / Migration]
- **Team Size**: [Solo / Small team / Large team]
- **Codebase Maturity**: [New / Growing / Mature]

### Technology Decisions
```yaml
Core Framework: [Next.js 15 / React / Node.js / Python FastAPI / etc.]
Language: [TypeScript / JavaScript / Python / Go / etc.]
UI Approach: [Server Components / SPA / SSG / etc.]
Styling: [Tailwind / CSS Modules / Styled Components / etc.]
Database: [PostgreSQL / MongoDB / SQLite / etc.]
ORM/Query: [Prisma / Drizzle / SQLAlchemy / etc.]
Testing: [Vitest / Jest / Pytest / etc.]
```

### Development Philosophy Preferences
- **Complexity Tolerance**: [Keep it simple / Balanced / Accept complexity when needed]
- **Type Safety**: [Strict TypeScript / Pragmatic types / Loose typing]
- **Testing Standards**: [High coverage (80%+) / Moderate / Minimal]
- **Documentation**: [Comprehensive / Essential only / Self-documenting code]

### Code Organization Preferences
- **Architecture**: [Vertical slice / Layered / Domain-driven / etc.]
- **File Size Limits**: [Strict (<500 lines) / Flexible / No limits]
- **Component Patterns**: [Composition / Inheritance / Mixed]
- **State Management**: [Server state + UI state / Global store / Context]

### Quality Standards
- **Code Review**: [Every PR / Periodic / None]
- **Linting**: [Strict rules / Standard / Minimal]
- **Formatting**: [Prettier enforced / Team convention / Flexible]
- **Git Workflow**: [Trunk-based / GitFlow / Feature branches]

### Special Considerations
- **Performance Requirements**: [Critical / Important / Standard]
- **Security Level**: [High (financial/health) / Standard / Internal only]
- **Accessibility**: [WCAG AA required / Best effort / Not required]
- **Browser Support**: [Modern only / Legacy support / Mobile-first]

### Anti-Patterns to Avoid
Based on past experience, we specifically want to avoid:
- [Anti-pattern 1]
- [Anti-pattern 2]
- [Anti-pattern 3]

---

## Request

Please generate a comprehensive CLAUDE.md file that:

1. **Follows the PRP framework structure** from CLAUDE-NEXTJS-15.md including:
   - Core Development Philosophy
   - AI Assistant Guidelines  
   - Code Structure & Modularity
   - Technology-specific features and patterns
   - Testing Strategy
   - Performance Guidelines
   - Security Best Practices

2. **Adapts patterns for my technology stack** (not just Next.js)

3. **Incorporates my preferences** while maintaining framework best practices

4. **Excludes**:
   - Project-specific features (those go in PRD)
   - Implementation details (those go in PRPs)
   - Validation gates (those go in PRPs)

5. **Includes**:
   - Clear "how we build" guidelines
   - Technology-specific patterns
   - Quality standards and practices
   - Common pitfalls for my stack

The CLAUDE.md should guide AI assistants on HOW to write code for this project, not WHAT features to build.
