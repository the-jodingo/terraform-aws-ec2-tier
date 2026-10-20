# Terraform AWS EC2 Tier — 3-Tier Web Application

Production-grade AWS infrastructure for a three-tier web application using Terraform.

Provisions a complete, modular, multi-AZ AWS environment designed for reliability, security, and scalability.

## Architecture

```
[VPC] —— [Public Subnets + NAT] —— [Internet Gateway]
              │
      ┌───────┼───────┐
      │       │       │
 [Web]   [App]   [Data]
(tier)  (tier)  (tier)
```

### What You Get

| Resource | Purpose |
|----------|---------|
| VPC (10.0.0.0/16) | Isolated network, 3 AZs |
| Public subnets | NAT gateways + internet access |
| Private subnets | App tier, RDS, data endponits |
| Application Load Balancer | Cross-zone, HTTPS, WAF-ready |
| Auto Scaling Group | 2–4 instances, health checks, scaling |
| Amazon RDS (MySQL) | Multi-AZ, encrypted storage |
| Security Groups | Role-based access control |
| S3 bucket | Encrypted log storage with versioning |

## Quick Start

```bash
git clone <repo>
cd terraform-aws-ec2-tier

# Configure
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars (set DB_PASSWORD!)

terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `aws_region` | `us-west-2` | AWS region |
| `environment` | `dev` | Environment (dev, staging, prod) |
| `app_name` | `myapp` | Application name |
| `instance_type` | `t3.medium` | EC2 instance type |
| `instance_count` | `2` | ASG desired capacity |
| `db_instance_class` | `db.t3.medium` | RDS instance class |
| `db_password` | — | Required. Database master password |
| `common_tags` | — | Extra tags merged into all resources |

## Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | VPC ID |
| `alb_dns_name` | ALB DNS name |
| `rds_endpoint` | Database endpoint |
| `security_group_ids` | Web tier security groups |
| `s3_bucket_name` | Log bucket name |

## Security Notes

- RDS storage is encrypted
- Security groups are scoped to tiers
- Secrets via `terraform.tfvars` (never commit)
- All resources tagged for cost tracking

## License

MIT
