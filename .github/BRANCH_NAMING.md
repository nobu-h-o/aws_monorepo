# Branch Naming Convention

This repository enforces a consistent branch naming convention based on Conventional Commits.

## Format

```
type/description
```

### Components

- **type**: One of the allowed types (same as PR title types)
- **description**: Brief, descriptive name in kebab-case

## Allowed Types

The same types used for PR titles:

- `feat` - New features
- `fix` - Bug fixes
- `docs` - Documentation changes
- `style` - Code style/formatting changes
- `refactor` - Code refactoring
- `perf` - Performance improvements
- `test` - Test additions/modifications
- `chore` - Maintenance tasks
- `ci` - CI/CD configuration
- `build` - Build system changes
- `revert` - Reverting changes

## Description Rules

The description part must:
- Use **kebab-case** (lowercase words separated by hyphens)
- Contain only: lowercase letters, numbers, and hyphens
- Be descriptive (2-5 words recommended)
- No spaces, underscores, or special characters

## Examples

### Valid Branch Names ✓

- `feat/user-authentication`
- `feat/multi-factor-auth`
- `fix/login-redirect-bug`
- `fix/memory-leak-in-processor`
- `docs/api-documentation`
- `docs/setup-instructions`
- `chore/update-dependencies`
- `refactor/simplify-auth-logic`
- `test/add-unit-tests`
- `perf/optimize-queries`

### Invalid Branch Names ✗

- `feature/user-auth` - Wrong type (use `feat`, not `feature`)
- `feat/User_Auth` - Not kebab-case (uppercase and underscores)
- `feat/user auth` - Contains spaces
- `user-authentication` - Missing type prefix
- `FEAT/user-auth` - Type must be lowercase
- `feat-user-auth` - Wrong separator (use `/`, not `-`)

## Special Branches

These system branches are excluded from validation:
- `main`
- `master`
- `develop`
- `staging`
- `production`

## Why This Matters

Consistent branch naming:
- Makes it easy to understand what a branch is for
- Enables automated workflows and tooling
- Keeps the repository organized
- Improves team collaboration

## How to Create Compliant Branches

```bash
# Good examples
git checkout -b feat/add-oauth-login
git checkout -b fix/cors-error
git checkout -b docs/update-readme

# Bad examples (these will fail validation)
git checkout -b add-oauth-login        # Missing type
git checkout -b feature/oauth          # Wrong type
git checkout -b feat/Add_OAuth         # Wrong case
```

## Fixing Non-Compliant Branches

If your branch name fails validation:

1. Rename your local branch:
   ```bash
   git branch -m old-branch-name new-compliant-name
   ```

2. If already pushed, delete the old remote branch and push the new one:
   ```bash
   git push origin --delete old-branch-name
   git push -u origin new-compliant-name
   ```

3. Update your PR to point to the new branch name
