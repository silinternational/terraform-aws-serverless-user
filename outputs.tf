output "aws_access_key_id" {
  value       = aws_iam_access_key.serverless.id
  description = "access key ID for the Serverless user"
}
output "aws_secret_access_key" {
  value       = aws_iam_access_key.serverless.secret
  sensitive   = true
  description = "secret access key for the Serverless user"
}
output "serverless_user_username" {
  value       = aws_iam_user.serverless.name
  description = "name of the Serverless user"
}
