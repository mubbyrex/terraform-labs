# Terraform Module Testing – AWS S3 Bucket

## Objective

Design and implement a production-grade testing strategy for a reusable Terraform module (`aws-s3-bucket`) that:

- Prevents invalid inputs early
- Enforces security requirements (encryption)
- Detects breaking changes
- Runs reliably in CI pipelines
- Scales as the module evolves

## What was done

- Built a reusable Terraform module for S3 bucket provisioning
- Implemented strict input validation (e.g. bucket naming rules)
- Enforced secure defaults (encryption, public access blocking)
- Created a dedicated `/tests` directory using `terraform test`
- Wrote multiple test scenarios:
  - Valid configuration
  - Invalid bucket name
  - Missing encryption
  - Edge cases
- Added assertions on actual resource configuration, not just plan success
- Structured tests to reflect real-world usage patterns

## Key Concepts

- **Validation is the first line of defense** — Prevents bad inputs before resources are created
- **Terraform tests validate behavior, not just execution** — Ensures resources are configured correctly
- **Modules should be treated as APIs** — Changes must not break existing consumers
- **Security must be enforced, not assumed** — Encryption and access controls are validated explicitly
- **Tests act as regression protection** — Catch unintended changes during development

## Test Structure

```
aws-s3-test-module/
  main.tf
  variables.tf
  outputs.tf

  tests/
    valid.tftest.hcl
    invalid_name.tftest.hcl
    no_encryption.tftest.hcl
    edge_cases.tftest.hcl
```

## Test Scenarios

### Valid Configuration

- Proper bucket name
- Encryption enabled
- Versioning enabled

Expected: Plan succeeds and all resources are correctly configured

### Invalid Bucket Name

- Uppercase characters / invalid format

Expected: Validation fails before resource creation

### Missing Encryption

- Simulates insecure configuration

Expected: Test fails if encryption is not properly configured

### Edge Cases

- Versioning disabled but encryption enabled
- Optional configurations

Expected: Valid behavior without breaking constraints

## Example Test Assertion

```hcl
assert {
  condition = anytrue([
    for r in aws_s3_bucket_server_side_encryption_configuration.this.rule :
    contains(
      ["AES256", "aws:kms"],
      r.apply_server_side_encryption_by_default[0].sse_algorithm
    )
  ])

  error_message = "Encryption must be enabled on the bucket"
}
```

## Key Commands

Run all tests:

```bash
terraform test
```

Expected output:

```
Success! 4 passed, 0 failed.
```

## CI Strategy (Design)

### When should tests run?

- On every Pull Request (PR)
- On merge to main branch
- Before releasing a new module version (tag)

### What should run?

- All tests for the module
- Optionally: only affected modules in a mono-repo setup

### What should fail the pipeline?

- Any failing test
- Validation errors
- Broken assertions

## Versioning Strategy

**Scenario: Releasing `v1.1.0`**

If you:

- Add a new required variable
- Change default behavior

Impact:

- Existing users may break
- Tests may fail

### Best Practices

- Use semantic versioning:
  - `v1.x.x` for backward compatible changes
  - `v2.0.0` for breaking changes
- Add new variables with defaults to avoid breaking users
- Update tests to reflect new behavior
- Maintain backward compatibility where possible

## Notes

- Terraform `set` vs `list` handling is important in tests
  - Sets require iteration (`for`)
  - Lists can be indexed (`[0]`)
- Tests should validate resource properties, not just execution
- Static test inputs are preferred for determinism
- Security (e.g. encryption) should always be explicitly validated

## Observations

- Validation alone is not enough — tests are required for safety
- Writing assertions forces deeper understanding of Terraform internals
- `terraform test` enables true module-level testing
- Proper testing prevents downstream team issues
- Treating modules as APIs improves long-term maintainability