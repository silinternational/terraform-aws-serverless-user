module "serverless-user" {
  source  = "silinternational/serverless-user/aws"
  version = "0.1.0"

  app_name   = "serverless-user"
  aws_region = var.aws_region
}
