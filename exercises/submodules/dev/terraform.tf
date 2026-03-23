terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket       = "mubbyrex-state-bucket"
    key          = "exercises/submodules/dev/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
    encrypt      = true
  }
}

locals {
  name = "${var.project_name}-${var.environment}"
  environment = var.environment


  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  )
}