# AWS Advanced Terraform Training Repository

© 2026 Michael Coulling-Green — QA

# Compute Module

## Purpose

The Compute module provisions EC2 instances that consume services exposed by the Network module.

The module is intentionally focused on workload deployment and does not create networking infrastructure.

---

## Inputs

| Variable          | Description                             |
| ----------------- | --------------------------------------- |
| prefix            | Naming prefix applied to resources      |
| base_tags         | Common tags applied to resources        |
| subnet_id         | Target subnet for EC2 deployment        |
| security_group_id | Security group applied to EC2 instances |
| instances         | Map of EC2 instances to create          |

---

## Outputs

This version of the module does not expose any outputs.

Future versions may expose:

* Instance IDs
* Private IP Addresses
* Public IP Addresses
* DNS Names

Outputs should only be added when required by downstream consumers.

---

## Design Principles

This module owns responsibility for:

* EC2 instance deployment
* Validation of compute-specific inputs
* Sanitization of instance naming conventions
* Application of workload-specific tags

The module assumes networking resources already exist and are supplied through module inputs.

---

## Instance Name Normalization

Instance names are normalized before deployment to ensure consistent Terraform addressing.

Examples:

| Input  | Normalized |
| ------ | ---------- |
| Web01  | web01      |
| WEB01  | web01      |
| Web 01 | web01      |
| web01  | web01      |

Duplicate names after normalization are rejected through validation.

---

## Example Usage

```hcl
module "compute" {
  source = "./modules/compute"

  instances         = var.instances
  subnet_id         = module.network.app_subnet_id
  security_group_id = module.network.security_group_id

  prefix    = local.prefix
  base_tags = local.base_tags
}
```

---

## Typical Consumers

Examples of consumers include:

* Environment Root Modules
* Application Deployments
* Future Platform Modules

The module should remain focused solely on workload deployment and should not create networking resources.
