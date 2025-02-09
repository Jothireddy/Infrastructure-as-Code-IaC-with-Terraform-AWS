
---

## 2. Terraform Files

### a. terraform/provider.tf

```hcl
provider "aws" {
  region = var.aws_region
}
