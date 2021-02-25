# Terraform module for creating an IAM user for the Serverless framework

This module creates an IAM user with a limited set of permissions such that the 
[Serverless](https://www.serverless.com/) 
framework can do it's job of creating and deploying lambda functions. The IAM policy included
as the default policy is known to work in multiple situations in our context and can hopefully
be useful for others. Additional parameters are supported to augment or replace the policy 
if needed as well. 

## Required Inputs
 - `app_env` - A short name for application environment, example: `prod`
 - `app_name` - A short name for this application, example: `backup-service`
 - `aws_region` - A valid AWS region where this lambda will be deployed, example: `us-east-1`

## Optional Inputs 
 - `extra_policies` - Optionally provide additional inline policies to attach to user. Default: `[]`
 - `policy_override` - Optionally provide a json policy to use instead of default. Default: `""`
 - `username` - Optionally provide a username for the serverless user. It defaults to `app_name-app_env-serverless`
 - `enable_api_gateway` - Optionally enable API Gateway related permissions. 
                          Needed for lambda functions that will be accessed via URL endpoints. Default: `false` 

## Outputs
 - `aws_access_key_id` - The new IAM user's access key ID
 - `aws_secret_access_key` - The new IAM user's secret access key

## Usage Example

```hcl
module "serverless-user" {
  source = "silinternational/serverless-user/aws"
  version = "1.0.0"
  
  app_env = "testing"
  app_name = "serverless-user"
  aws_region = "us-east-1"
}

output "serverless-user-access-key-id" {
  value = module.serverless-user.aws_access_key_id
}
output "serverless-user-secret-access-key" {
  value = module.serverless-user.aws_secret_access_key
}
```


## License - MIT
MIT License

Copyright (c) 2021 SIL International

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.