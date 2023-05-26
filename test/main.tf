module "minimal" {
  source = "../"

  app_name   = "test"
  aws_region = local.aws_region
}

module "all" {
  source = "../"

  app_name           = "test"
  aws_region         = local.aws_region
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
  aws_region = "us-east1"
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
