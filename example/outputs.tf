output "serverless-user-access-key-id" {
  value = module.serverless-user.aws_access_key_id
}

output "serverless-user-secret-access-key" {
  value     = module.serverless-user.aws_secret_access_key
  sensitive = true
}
