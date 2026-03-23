# Terraform Submodules Exercise

## Objective

Implement a Terraform setup that consumes shared modules via Git submodules, while supporting multiple environments and controlled module versioning.

---

## What was done

- Created a separate repo for reusable Terraform modules
- Added the modules repo as a Git submodule
- Used modules locally via relative paths
- Simulated multiple environments (dev, stage)
- Practiced version control using Git tags
- Upgraded module versions safely

---

## Key Commands

### Add submodule
```bash
git submodule add git@github.com:<git-username>/terraform-modules.git modules