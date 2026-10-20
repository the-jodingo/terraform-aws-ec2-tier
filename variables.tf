variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

variable "owner" {
  description = "Owner contact"
  type        = string
  default     = "devops@company.com"
}

variable "vpc_cidr" {
  description = "Base VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Department = "Platform"
    ManagedBy  = "Terraform"
  }
}

# EC2 / ASG variables
variable "instance_type" {
  description = "EC2 instance type for the app tier"
  type        = string
  default     = "t3.medium"
}

variable "instance_count" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "AMI ID for the app tier (override for your environment)"
  type        = string
  default     = ""
}

# RDS variables
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password (must be set in terraform.tfvars)"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "RDS port"
  type        = number
  default     = 3306
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Enable RDS Multi-AZ"
  type        = bool
  default     = false
}

# ALB variables
variable "alb_enabled" {
  description = "Enable Application Load Balancer"
  type        = bool
  default     = true
}

variable "alb_security_group_rules" {
  description = "Ingress rules for the ALB security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
