provider "aws" {
  region = var.aws_region
}

provider "random" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "latest_amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp3"
}

locals {
  name = "${var.environment}-${var.app_name}"

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
