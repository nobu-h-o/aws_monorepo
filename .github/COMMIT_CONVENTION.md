# Commit Convention Guide

This repository follows [Conventional Commits](https://www.conventionalcommits.org/) specification for PR titles and branch names.

## PR Title Format

```
type(optional-scope): description
```

### Required Components

- **type**: One of the allowed types (see below)
- **description**: Brief summary of changes (starts with lowercase)
- **scope** (optional): Additional context in parentheses

### Allowed Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | New feature | `feat: add user authentication` |
| `fix` | Bug fix | `fix: resolve login redirect issue` |
| `docs` | Documentation changes | `docs: update API documentation` |
| `style` | Code style changes (formatting, missing semi-colons, etc.) | `style: format code with prettier` |
| `refactor` | Code refactoring (neither fixes bug nor adds feature) | `refactor: simplify authentication logic` |
| `perf` | Performance improvements | `perf: optimize database queries` |
| `test` | Adding or updating tests | `test: add unit tests for auth service` |
| `chore` | Maintenance tasks (dependencies, build, etc.) | `chore: update dependencies` |
| `ci` | CI/CD configuration changes | `ci: add workflow for automated testing` |
| `build` | Build system changes | `build: update webpack configuration` |
| `revert` | Revert previous commit | `revert: undo feature X` |

## Examples

### Valid PR Titles ✓

- `feat: add multi-factor authentication`
- `feat(auth): add OAuth provider support`
- `fix: prevent memory leak in data processor`
- `fix(api): handle null response from external service`
- `docs: add setup instructions to README`
- `chore: upgrade React to v18`
- `refactor(utils): simplify date formatting logic`

### Invalid PR Titles ✗

- `Add authentication` - Missing type prefix
- `FEAT: add authentication` - Type must be lowercase
- `feature: add authentication` - Wrong type (use `feat`, not `feature`)
- `feat:add authentication` - Missing space after colon
- `feat authentication` - Missing colon
- `updated the readme` - No type, wrong format

## Breaking Changes

For breaking changes, add `!` after the type/scope:

```
feat!: remove support for Node 12
feat(api)!: change authentication endpoint structure
```

## Common Mistakes

1. **Wrong case**: Types must be lowercase (`feat`, not `FEAT`)
2. **Wrong separator**: Use `:` with a space, not `-` or other characters
3. **Wrong type name**: Use `feat` not `feature`, `fix` not `bugfix`
4. **Missing description**: Every PR title needs a description after the colon

## How to Fix Violations

If your PR title fails validation:

1. Edit the PR title on GitHub (don't create a new PR)
2. Ensure it follows the format: `type(optional-scope): description`
3. Use one of the allowed types listed above
4. The validation check will automatically re-run

## Why This Matters

Consistent commit conventions enable:
- Automatic changelog generation
- Semantic versioning automation
- Easy navigation of project history
- Clear communication of changes
