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
 * If enable_api_gateway is true, add policy
 */
data "template_file" "api_gateway_policy" {
  template = file("${path.module}/api-gateway-policy.json")

  vars = {
    aws_region = var.aws_region
  }
}
resource "aws_iam_user_policy" "api_gateway_policy" {
  count  = var.enable_api_gateway ? 1 : 0
  policy = data.template_file.api_gateway_policy.rendered
  user   = aws_iam_user.serverless.name
}

/*
 * If there are any extra_policies, for_each add to user
 */
resource "aws_iam_user_policy" "extra_policies" {
  for_each = toset(var.extra_policies)
  policy   = each.key
  user     = aws_iam_user.serverless.name
} 