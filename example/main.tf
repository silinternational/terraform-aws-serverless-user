module "serverless-user" {
  source = "../"

  app_name   = "serverless-user"
  aws_region = var.aws_region
}
