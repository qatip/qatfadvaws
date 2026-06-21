# Lab 6B – GitHub Actions Pipeline Architecture Guide

## Purpose

The objective is not simply to automate Terraform. The objective is to teach the evolution of promotion governance from:

Manual execution

to

Local pipelines

to

Centralised CI/CD execution

to

Environment-scoped deployment ownership

while preserving the promotion model introduced in Lab 6A.

---

# Pipeline Groups

The workflows are divided into two categories:

## PR Plan Pipelines

```text
pr-plan-dev.yml
pr-plan-test.yml
pr-plan-prod.yml
```

## Change Pipelines

```text
change-dev.yml
change-test.yml
change-prod.yml
```

These two groups intentionally perform different roles.

---

# PR Plan Pipelines

## Purpose

The PR Plan pipelines provide visibility.

They answer the question:

"What would Terraform do if this change were accepted?"

They do not deploy infrastructure.

They do not modify state.

They do not make promotion decisions.

They exist purely to assist review.

## Execution Flow

```text
Pull Request Created
        ↓
Terraform Init
        ↓
Terraform Validate
        ↓
Terraform Plan
        ↓
Publish Plan Output
        ↓
STOP
```

No Terraform Apply occurs.

The environment remains unchanged.

## Why Separate Pipelines?

A change affecting:

```text
envs/dev/**
```

should only generate a DEV plan.

A change affecting:

```text
envs/prod/**
```

should only generate a PROD plan.

This keeps validation simple, deterministic and auditable.

No environment-detection scripting is required.

---

# Change Pipelines

## Purpose

The Change pipelines perform deployment.

They answer the question:

"An approved change now exists. Apply it."

Unlike PR plan workflows, these pipelines execute Terraform Apply.

## Execution Flow

```text
Configuration Change Accepted
        ↓
Terraform Init
        ↓
Terraform Validate
        ↓
Terraform Plan
        ↓
Terraform Apply
```

The target environment state is updated.

---

# Environment Ownership

Each environment receives its own deployment workflow.

```text
change-dev.yml
change-test.yml
change-prod.yml
```

This replaces the earlier:

```text
change-all.yml
```

design.

Benefits include:

• Independent promotion schedules
• Simpler troubleshooting
• Clearer ownership
• Reduced workflow complexity
• Better alignment with GitOps principles

---

# FEATURE_PHASE

All workflows contain:

```yaml
FEATURE_PHASE: "1"
```

This variable is intentionally included for future labs.

At Lab 6B:

```text
FEATURE_PHASE = 1
```

means:

Environment-scoped planning and deployment only.

No intent governance.

No ownership governance.

No release categorisation.

Future labs will increase this value to enable additional governance controls.

Examples may include:

```text
FEATURE_PHASE = 2
```

Require explicit promotion intent.

```text
FEATURE_PHASE = 3
```

Require environment ownership validation.

Students are not expected to modify this variable during Lab 6B.

Its presence is deliberate and prepares the workflows for later evolution.

---

# AWS Authentication

Authentication uses GitHub OIDC.

No long-lived AWS credentials are stored in GitHub.

The workflows assume the existence of:

```text
AWS_ROLE_ARN
AWS_REGION
```

configured as repository variables.

GitHub obtains a short-lived token and assumes the configured IAM role.

---

# Terraform State

Terraform state is stored in Amazon S3.

State locking uses:

```text
use_lockfile=true
```

Native S3 lock files are used.

No DynamoDB locking table is required.

---

# Learning Objectives

These workflows are not intended to teach GitHub Actions syntax.

They exist to reinforce several architectural concepts:

• Promotion is represented by version pin changes

• Humans decide when promotion occurs

• Pipelines execute promotion consistently

• Planning and deployment are separate activities

• Environment ownership matters

• Governance evolves incrementally

• Automation alone does not create intent

The final point becomes the focus of Part 4.
