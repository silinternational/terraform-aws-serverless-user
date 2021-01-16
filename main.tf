/*
 * Create IAM user for Serverless
 */
resource "aws_iam_user" "serverless" {
  name = var.username != "" ? var.username : "${var.app_name}-${var.app_env}-serverless"
}

/*
 * Create Access Key/Secret for user
 */
resource "aws_iam_access_key" "serverless" {
  user = aws_iam_user.serverless.name
}

/*
 * Use policy template to generate IAM policy for user
 */
data "template_file" "serverless_policy" {
  template = file("${path.module}/serverless-iam-policy.json")

  vars = {
    app_name   = var.app_name
    app_env    = var.app_env
    aws_region = var.aws_region
  }
}

/*
 * Create IAM policy from template content or var.policy_override if set
 */
resource "aws_iam_policy" "serverless" {
  name        = "${var.app_name}-${var.app_env}-serverless"
  description = "Serverless deployment policy"

  policy = var.policy_override != "" ? var.policy_override : data.template_file.serverless_policy.rendered
}

/*
 * Attach policy to user
 */
resource "aws_iam_user_policy_attachment" "serverless" {
  user       = aws_iam_user.serverless.name
  policy_arn = aws_iam_policy.serverless.arn
}

/*
 * If there are any extra_policies, for_each add to user
 */
resource "aws_iam_user_policy" "extra_policies" {
  for_each = toset(var.extra_policies)
  policy   = each.key
  user     = aws_iam_user.serverless.name
} 