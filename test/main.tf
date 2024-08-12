module "minimal" {
  source = "../"

  app_name = "test"
}

module "all" {
  source = "../"

  app_name           = "test"
  aws_region_policy  = "*"
  enable_api_gateway = true
  extra_policies     = ["extra_policies"]
  policy_override    = "policy_override"
  username           = "test_user"
}

provider "aws" {
  region = local.aws_region
}

locals {
  aws_region = "us-east-1"
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
  }
}
