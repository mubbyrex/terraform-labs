# Terraform Git Module Source Exercise

## Objective

Implement a Terraform setup that consumes shared modules using Git module sources (`?ref=`), while supporting version control and environment differences.

---

## What was done

* Created a separate repo for reusable Terraform modules
* Consumed modules directly from Git using Terraform `source`
* Removed the need for Git submodules
* Simulated multiple environments (dev, stage)
* Practiced version control using Git tags
* Upgraded module versions independently per environment

---

## Key Concepts

* Terraform pulls modules directly from Git during `terraform init`
* Versioning is controlled using the `?ref=` parameter
* Each environment can use a different module version
* No manual Git operations are required inside the project

---

## Example Usage

```hcl
module "vpc" {
  source = "git::https://github.com/<git-username>/terraform-modules.git//aws/vpc?ref=v1.0.0"

  cidr_block = "10.0.0.0/16"
}
```

---

## Key Commands

### Initialize Terraform (downloads modules)

```bash
terraform init
```

---

### Upgrade module version

Update the version in your `.tf` file:

```hcl
ref = "v1.1.0"
```

Then run:

```bash
terraform init -upgrade
```

---

### Plan changes

```bash
terraform plan
```

---

## Notes

* Terraform manages module versions, not Git directly
* Modules are cached in `.terraform/modules/`
* Using tags (`v1.0.0`) is preferred over branches for stability
* This approach is simpler and more production-friendly than submodules

---

## Observations

* Much simpler than Git submodules
* Version is clearly visible in Terraform code
* Easier to manage across environments
* Works naturally with CI/CD pipelines
