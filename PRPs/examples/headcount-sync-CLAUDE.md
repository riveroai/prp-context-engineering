# HeadcountSync Development Rules for Claude

This file provides comprehensive guidance to Claude when working with the HeadcountSync codebase.

## Core Development Philosophy

### KISS (Keep It Simple, Stupid)
Simplicity should be a key goal in design. Choose straightforward solutions over complex ones. Simple solutions are easier to understand, maintain, and debug.

### YAGNI (You Aren't Gonna Need It)
Avoid building functionality on speculation. Implement features only when they are needed, not when you anticipate they might be useful.

### Design Principles
- **Dependency Inversion**: High-level modules should not depend on low-level modules
- **Open/Closed Principle**: Open for extension, closed for modification
- **Single Responsibility**: Each module/component does one thing well
- **Composition over Inheritance**: Prefer component composition patterns

## 🤖 AI Assistant Guidelines

### Context Awareness
- When implementing features, ALWAYS check existing patterns first
- Reference specific PRD sections when implementing features
- Use existing utilities before creating new ones
- Check for similar functionality in codebase before implementing

### Search Command Requirements
**CRITICAL**: Always use `rg` (ripgrep) instead of `grep`:
```bash
# ❌ Don't use
grep -r "allocation" .

# ✅ Use instead
rg "allocation"
rg --files -g "*.tsx"
```

### Workflow Patterns
- Create comprehensive plan before implementation
- Break complex tasks into testable units
- Validate understanding before proceeding
- Use existing patterns from codebase

## 🧱 Code Structure & Modularity

### File and Component Limits
- **Maximum 500 lines per file** - Split if approaching limit
- **Components under 200 lines** - Refactor if larger
- **Functions under 50 lines** - Single responsibility
- **Organize by feature** - Group related functionality

### When to Extract
- After 3 uses of similar pattern
- When file approaches size limit
- When component has multiple responsibilities
- When testing becomes complex

## 🚀 Next.js 15 & React 19 Key Features

### Next.js 15 Core Features
- **Turbopack**: Fast bundler for development
- **App Router**: File-system based routing with layouts
- **Server Components**: Default for data fetching
- **Server Actions**: Type-safe server mutations
- **Parallel Routes**: Dashboard layouts
- **Intercepting Routes**: Modal patterns

### React 19 Features
- **React Compiler**: Auto-optimization (no memo needed)
- **Actions**: Built-in async state handling
- **use() API**: Simplified data fetching
- **Document Metadata**: Native SEO support

### TypeScript Integration
```typescript
// ✅ CORRECT: Modern React typing
import { ReactElement } from 'react';

function Component(): ReactElement {
  return <div />;
}

// ❌ WRONG: Legacy JSX namespace
function Component(): JSX.Element {
  return <div />;
}
```

## 🏗️ Project Structure (Vertical Slice Architecture)

```
src/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Auth group routes
│   ├── (dashboard)/       # Main app routes
│   └── api/               # API routes
├── features/              # Feature modules
│   └── [feature]/
│       ├── components/    # Feature components
│       ├── hooks/         # Feature hooks
│       ├── api/          # API integration
│       ├── schemas/      # Zod schemas
│       └── types/        # TypeScript types
├── components/           
│   ├── ui/               # shadcn/ui base
│   └── shared/           # Shared components
├── lib/                  # Core utilities
│   ├── api/             # API client
│   ├── auth/            # Auth utilities
│   ├── db/              # Database client
│   └── utils/           # Helpers
└── types/               # Global types
```

## 🎯 TypeScript Configuration

### Strict Mode Requirements
```json
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true
  }
}
```

### Type Requirements
- **No `any` types** - Use `unknown` for untyped data
- **Explicit return types** for all functions
- **Zod schema inference** for data types
- **Branded types** for IDs

## 🛡️ Data Validation Strategy

### Validation Rules
- **Validate ALL external data** with Zod
- **Parse at system boundaries** (API routes, forms)
- **Fail fast** with clear error messages
- **Type inference** from schemas

```typescript
// Pattern for all external data
const schema = z.object({
  id: z.string().uuid().brand<'UserId'>(),
  email: z.string().email()
});

type User = z.infer<typeof schema>;

// In API routes
const data = schema.parse(request.body);
```

## 🧪 Testing Strategy

### Coverage Requirements
- **Minimum 80% coverage** for all code
- **100% coverage** for business logic
- **Integration tests** for API routes
- **Component tests** for UI logic

### Testing Patterns
```typescript
// Co-locate tests with code
src/features/allocations/
├── components/
│   ├── AllocationBar.tsx
│   └── __tests__/
│       └── AllocationBar.test.tsx
```

### Test Categories
1. **Unit Tests**: Pure functions, utilities
2. **Integration Tests**: API routes, database
3. **Component Tests**: UI behavior
4. **E2E Tests**: Critical user flows

## 🎨 UI/UX Standards

### Component Guidelines
- **Server Components by default**
- **Client Components** only for interactivity
- **Loading states** for all async operations
- **Error boundaries** for error handling
- **Empty states** for no data scenarios

### Accessibility Requirements
- **ARIA labels** for all interactive elements
- **Keyboard navigation** support
- **Screen reader** compatibility
- **Color contrast** compliance

## 🚀 Performance Guidelines

### Optimization Strategies
- **Dynamic imports** for large components
- **Image optimization** with next/image
- **Font optimization** with next/font
- **API response caching** with proper headers
- **Database query optimization** with indexes

### Bundle Size Management
- Monitor with `@next/bundle-analyzer`
- Code split at route boundaries
- Lazy load heavy dependencies

## 💅 Code Style & Quality

### Naming Conventions
- **Components**: PascalCase
- **Functions/Hooks**: camelCase
- **Constants**: UPPER_SNAKE_CASE
- **Types/Interfaces**: PascalCase
- **Files**: kebab-case

### Documentation Requirements
- **JSDoc** for all exported functions
- **Props documentation** for components
- **README** for complex features
- **Inline comments** for complex logic

## 🔒 Security Best Practices

### Data Protection
- **Never trust client data** - Always validate
- **Sanitize user input** - Prevent XSS
- **Use parameterized queries** - Prevent SQL injection
- **Secure API routes** - Check authentication

### Authentication Rules
- **Session validation** on every request
- **Role-based access** control
- **Audit logging** for sensitive operations

## 📋 Development Commands

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "test": "vitest",
    "test:coverage": "vitest --coverage",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "db:push": "prisma db push",
    "db:generate": "prisma generate"
  }
}
```

## ⚠️ Common Pitfalls to Avoid

### React/Next.js
- Don't use `useEffect` for data fetching in Server Components
- Don't access browser APIs in Server Components
- Don't pass functions to Client Components from Server Components

### TypeScript
- Don't use type assertions unless absolutely necessary
- Don't ignore type errors
- Don't use `@ts-ignore`

### Performance
- Don't fetch data in layout components
- Don't import large libraries client-side
- Don't create unnecessary Client Components

## 🎯 Quality Checklist

Before committing code:
- [ ] TypeScript compiles without errors
- [ ] Tests pass with coverage requirements
- [ ] ESLint passes without warnings
- [ ] Components handle all states (loading, error, empty, success)
- [ ] Accessibility requirements met
- [ ] No `console.log` statements
- [ ] Documentation updated

---

**Remember**: This document defines HOW we build. WHAT we build is in PRPs with full context.
