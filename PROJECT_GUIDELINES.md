# Project Guidelines - Food Reviews SaaS MVP

## Core Development Principles

### 1. Code Quality Standards
- **Top-notch code quality** must be maintained at all times
- All code should be clean, readable, and maintainable
- Follow Ruby on Rails conventions and best practices
- Utilize RuboCop (already configured) to enforce code style consistency
- Write self-documenting code with clear naming conventions

### 2. Best Practices
- Always follow Rails best practices and conventions
- Adhere to SOLID principles
- Use appropriate design patterns where they add value
- Implement proper error handling and validation
- Write meaningful comments where code logic is complex (but prefer self-documenting code)
- Follow RESTful conventions for routes and controllers
- Use service objects for complex business logic
- Implement proper database indexing for performance

### 3. Backward Compatibility
- **Critical**: New features must not break existing functionality
- Always maintain backward compatibility when adding new features
- Use feature flags when introducing major changes
- Deprecation warnings should be added before removing features
- Database migrations must be reversible
- API changes should follow versioning strategy
- Test existing functionality after adding new features

### 4. Code Redundancy Prevention
- **No code duplication** - use DRY (Don't Repeat Yourself) principle
- Extract common functionality into:
  - Shared concerns/modules
  - Service objects
  - Helper methods
  - Partial views
  - Shared components
- Reuse existing code and utilities before creating new ones
- Regular refactoring to eliminate accumulated redundancy

### 5. Solution Selection
- Always suggest and implement the **best possible solution** for any given problem
- Consider:
  - Performance implications
  - Scalability requirements
  - Maintainability
  - Security best practices
  - User experience
  - Cost-effectiveness
- Evaluate multiple approaches before implementation
- Choose proven, stable solutions over experimental ones
- Document architectural decisions when necessary

## Technical Stack Notes

- **Framework**: Rails 8.0.2
- **Ruby Version**: 3.4.5
- **Database**: PostgreSQL
- **Frontend**: Tailwind CSS, Hotwire (Turbo + Stimulus)
- **Code Quality**: RuboCop Rails Omakase, Brakeman (security)

## Development Workflow

1. Before adding new features, review existing codebase to avoid duplication
2. Test backward compatibility after changes
3. Run linters and security checks before committing
4. Consider performance implications of new features
5. Document complex logic and architectural decisions

---

**Status**: Awaiting MVP requirements...

