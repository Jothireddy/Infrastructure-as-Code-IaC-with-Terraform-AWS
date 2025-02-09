# Infrastructure as Code (IaC) with Terraform & AWS

This project demonstrates how to automate the provisioning of AWS resources using Terraform in a GitOps workflow. It provisions a basic set of AWS services including:

- **EC2 Instance:** A virtual machine running in AWS.
- **RDS Instance:** A managed relational database.
- **S3 Bucket:** An object storage service.

The infrastructure is defined as code and stored in this Git repository. With the GitOps approach, any change committed to the repository triggers a CI/CD pipeline (using GitHub Actions) that runs Terraform to apply the changes automatically.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup & Deployment](#setup--deployment)
  - [Local Deployment](#local-deployment)
  - [GitOps via GitHub Actions](#gitops-via-github-actions)
- [Configuration Details](#configuration-details)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This repository contains Terraform code that automates the provisioning of a Virtual Private Cloud (VPC), an EC2 instance, an RDS instance, and an S3 bucket on AWS. By adopting a GitOps approach, every change committed to this repository can trigger a CI/CD pipeline (via GitHub Actions) to ensure that the desired state is always applied to the AWS environment.

---

## Features

- **Automated Provisioning:** Fully automated creation and updates of AWS resources using Terraform.
- **GitOps Workflow:** Infrastructure updates are driven by Git commits, enabling version control, rollback, and auditing.
- **CI/CD Integration:** GitHub Actions runs Terraform commands (init, plan, and apply) to automatically update the infrastructure.
- **Modular Configuration:** Uses input variables to simplify customizations (e.g., region, instance type, CIDRs).

---

## Technologies Used

- **Terraform:** Infrastructure as Code tool to define and provision AWS resources.
- **AWS:** Cloud provider where EC2, RDS, and S3 are provisioned.
- **GitOps:** Practice of using Git as the single source of truth for infrastructure.
- **GitHub Actions:** CI/CD tool to automate Terraform workflows.

---

## Project Structure

iac-terraform-aws-gitops/ ├── README.md ├── terraform/ │ ├── main.tf │ ├── provider.tf │ ├── variables.tf │ └── outputs.tf ├── .github/ │ └── workflows/ │ └── terraform.yml └── scripts/ └── deploy.sh


- **terraform/main.tf:** Contains the definitions for the VPC, EC2, RDS, and S3 resources.
- **terraform/provider.tf:** Configures the AWS provider.
- **terraform/variables.tf:** Defines customizable parameters for your infrastructure.
- **terraform/outputs.tf:** Exposes key outputs like instance IP, RDS endpoint, and S3 bucket name.
- **.github/workflows/terraform.yml:** Automates Terraform runs on push/PR events.
- **scripts/deploy.sh:** An optional helper script for local testing and deployment.

---

## Prerequisites

- **Terraform** (v1.0+ recommended)  
  [Download Terraform](https://www.terraform.io/downloads.html)
- **AWS CLI** (configured with appropriate credentials)  
  [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **GitHub Account** (for hosting the repository and enabling GitHub Actions)
- **Git:** Installed and configured on your machine.

---

## Setup & Deployment

### Local Deployment

1. **Clone the repository:**

   ```bash
   git clone <repository_url>
  ```

Navigate to the Terraform directory and initialize Terraform:

```
cd terraform
terraform init
```
Plan and apply the configuration:

```
terraform plan -out=tfplan
terraform apply -auto-approve tfplan
```
View the outputs:

```
terraform output
```
Alternatively, use the provided script:

```
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```
GitOps via GitHub Actions
A GitHub Actions workflow is configured in .github/workflows/terraform.yml to run on every commit to the main branch (or via pull requests). Ensure that you add the following secrets to your repository settings:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION

This CI/CD pipeline will automatically initialize, plan, and apply your Terraform configuration, ensuring that your AWS infrastructure stays in sync with the Git repository.

Configuration Details
terraform/provider.tf
Configures the AWS provider using the region specified in variables.tf.

terraform/variables.tf
Defines parameters such as:

aws_region: AWS region (e.g., us-west-2)
vpc_cidr: CIDR block for the VPC
instance_type: EC2 instance type (e.g., t3.micro)
ami_id: AMI to use for the EC2 instance (this example uses a placeholder)
db_username, db_password: Credentials for the RDS instance (in production, use a more secure method)
s3_bucket_name: Name for the S3 bucket
terraform/main.tf
Contains the resource definitions for:

A VPC with a public subnet, Internet Gateway, and route table.
An EC2 instance.
An RDS instance.
An S3 bucket.
terraform/outputs.tf
Exports important outputs like the public IP of the EC2 instance, the RDS endpoint, and the S3 bucket name.

Troubleshooting
Terraform Init/Apply Errors:
Ensure your AWS credentials are valid and that you have sufficient permissions.

Resource Conflicts:
If a resource already exists (e.g., S3 bucket name must be globally unique), modify the variables accordingly.

GitHub Actions Failures:
Check the Actions logs for details and verify that repository secrets are correctly set.

Contributing
Contributions are welcome! Please fork this repository and submit pull requests for any enhancements or bug fixes. Ensure that your changes follow best practices for Terraform and AWS security.

License
This project is licensed under the MIT License. See the LICENSE file for details.

Happy provisioning and GitOps-ing!

yaml
Copy
Edit
