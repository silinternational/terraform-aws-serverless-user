output "aws_access_key_id" {
  value = aws_iam_access_key.serverless.id
}
output "aws_secret_access_key" {
  value = aws_iam_access_key.serverless.secret
  sensitive = true
}
output "serverless_user_username" {
  value = aws_iam_user.serverless.name
}
