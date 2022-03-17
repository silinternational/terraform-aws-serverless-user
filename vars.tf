variable "app_name" {
  type        = string
  description = "A short name for this application, example: backup-service. Must be 24 characters or less, including the stage name and a hyphen."
}

variable "aws_region" {
  type        = string
  description = "A valid AWS region where this lambda will be deployed"
}

variable "enable_api_gateway" {
  type        = bool
  default     = false
  description = "If true, an additional policy will be attached for deployment to API Gateway"
}

variable "extra_policies" {
  type        = list(string)
  description = "Optionally provide additional inline policies to attach to user"
  default     = []
}

variable "policy_override" {
  type        = string
  description = "Optionally provide a json policy to use instead of default"
  default     = ""
}

variable "username" {
  type        = string
  description = "Optionally provide a username for the serverless user. It defaults to app_name-serverless"
  default     = ""
}
