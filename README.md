# Infrastructure as Code — AWS EC2 + Docker Provisioning

This repository contains Infrastructure as Code (IaC) for provisioning and configuring a container-ready server on AWS.

The stack uses:

- Terraform → infrastructure provisioning
- Ansible → configuration management
- Docker → container runtime

> This repository is part of a broader DevOps pipeline project where applications are deployed via CI/CD after the infrastructure is provisioned.

---

## Architecture Overview

The workflow follows a common DevOps pattern:

```
Terraform
│
▼
AWS Infrastructure
(VPC + Security Group + EC2)
│
▼
Ansible
(Docker installation & configuration)
│
▼
Server ready for CI/CD deployment

Once the infrastructure is ready, application deployment can be handled by a CI/CD pipeline (e.g. GitHub Actions).
```

---

Repository Structure

```
.
├── ansible
│ ├── inventory.ini # Target host inventory
│ ├── playbook.yml # Main Ansible playbook
│ └── roles
│ └── docker
│ └── tasks
│ └── main.yml # Docker installation tasks
│
├── terraform
│ ├── ec2.tf # EC2 instance configuration
│ ├── vpc.tf # VPC networking setup
│ ├── sg.tf # Security group rules
│ ├── providers.tf # Terraform providers
│ ├── variables.tf # Input variables
│ ├── terraform.tfvars # Variable values (ignored in git)
│ ├── outputs.tf # Infrastructure outputs
│
├── LICENSE
└── README.md
```

---

## Infrastructure Components

Terraform provisions the following resources:

- VPC
- Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance

The EC2 instance acts as a Docker host for running containerized applications.

---

## Configuration Management

Ansible is used to configure the EC2 instance after it is created.

The playbook performs tasks such as:

- Updating the system
- Installing Docker
- Enabling Docker service
- Adding the "ec2-user" to the Docker group

This ensures the instance is ready to run containers immediately.

---

## Prerequisites

You need the following tools installed locally:

- Terraform
- Ansible
- AWS CLI
- SSH access to the EC2 instance

AWS credentials must be configured:

aws configure

---

## Usage

1 Provision Infrastructure

Navigate to the Terraform directory:

cd terraform

Initialize Terraform:

terraform init

Preview the infrastructure plan:

terraform plan

Apply the configuration:

terraform apply

After successful provisioning, Terraform will output the EC2 public IP.

---

2 Configure Server with Ansible

Update the inventory file with the EC2 public IP.

Example:

[ec2-instance]
54.xxx.xxx.xxx ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/key.pem

Run the playbook:

ansible-playbook -i inventory.ini playbook.yml

The EC2 instance will now have Docker installed and running.

---

Example Workflow

Typical usage flow:

terraform apply
│
▼
EC2 instance created
│
▼
ansible-playbook
│
▼
Docker host ready
│
▼
CI/CD deploys application container

---

Security Notes

Sensitive files are excluded from version control:

- "terraform.tfvars"
- "terraform.tfstate"
- "terraform.tfstate.backup"

Credentials and secrets should never be committed to the repository.

---

Future Improvements

Possible enhancements:

- Remote Terraform state (S3 + DynamoDB)
- Automated inventory generation from Terraform outputs
- CI/CD pipeline to run Terraform and Ansible automatically
- Kubernetes deployment instead of standalone Docker
- Infrastructure validation and linting

---

License

This project is licensed under the terms of the LICENSE file included in this repository.
