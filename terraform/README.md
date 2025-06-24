# Buddywise Cloud Infrastructure – Terraform

This Terraform configuration automates the provisioning of a secure and scalable AWS infrastructure to deploy the Buddywise containerized frontend and backend applications using ECS Fargate and an Application Load Balancer with path-based routing.

---

## 📁 Structure

```plaintext
terraform/
├── providers.tf          # AWS provider and region
├── variables.tf          # Input variables
├── network.tf            # VPC, subnet, route tables
├── security.tf           # Security groups
├── alb.tf                # Application Load Balancer
├── ecs.tf                # ECS clusters, tasks, services for frontend and backend
├── outputs.tf            # Outputs for reference
├── main.tf               # (Optional) summary file
└── README.md             # This documentation
```

---

## 🚀 Deployment Instructions

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Preview the Plan
```bash
terraform plan
```

### 3. Apply the Infrastructure
```bash
terraform apply
```

### 4. Destroy the Infrastructure
```bash
terraform destroy
```

---

## 🔐 Features

- **Two ECS Fargate Services**: One for frontend (port 3000), one for backend (port 8000)
- **ALB Path-Based Routing**: `/` for frontend, `/api/*` for backend
- **Security Groups**: Restrict access to HTTP/HTTPS only
- **CloudWatch Logging**: For both containers
- **Modular Code**: Clean separation by concern

---

## 📝 Notes

- Frontend and backend images should be pushed to ECR.
- ALB routes:
    - `/` → Frontend on port 3000
    - `/api/*` → Backend on port 8000
- Replace container image references in `ecs.tf` as needed.
- All logs are sent to CloudWatch automatically.

---

## 📌 Requirements

- Terraform CLI >= 1.0
- AWS CLI authenticated

---