terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }
}

provider "random" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name = "${var.environment}-${var.app_name}"

  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = [for i, az in data.aws_availability_zones.available.names : cidrsubnet(var.vpc_cidr, 8, i)]
  private_subnet_cidrs  = [for i, az in data.aws_availability_zones.available.names : cidrsubnet(var.vpc_cidr, 8, i + 3)]

  common_tags = merge(
    var.common_tags,
    {
      Project     = local.name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner
    }
  )
}
