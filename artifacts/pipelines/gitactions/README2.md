# GitHub Actions workflows for AWS Lab 6B Part 3

These files are the GitHub Actions equivalents of the Azure DevOps plan and change pipelines.

- `pr-plan-*.yml` runs during pull requests and stops at `terraform plan`.
- `change-*.yml` runs after merge to `main` and performs `terraform apply` for one environment only.
- `FEATURE_PHASE` remains set to `1` in Lab 6B and is retained for future governance labs.
- AWS authentication uses GitHub OIDC.
- Terraform state uses S3 with `use_lockfile=true`; no DynamoDB lock table is required.
