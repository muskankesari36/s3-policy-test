provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "mystatebucket9018"
    key            = "s3-policy-test/tf.state"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tf-state-lock"

  }
}

#calling central modules for vpc and subnets deployment
module "libryo_vpc" {
  source     = "./tf_aws_vpc"
  aws_region = var.aws_region
  tags = var.tags
  vpc_config = {
    vpc_name   = var.vpc_details.vpc_name
    cidr_block = var.vpc_details.cidr_block
    enable_dns_hostnames = var.vpc_details.enable_dns_hostnames
  }
  vpc_flow_log_config = {
    enable_vpc_flow_log = var.vpc_flow_log_config.enable_vpc_flow_log
    s3_bucket_arn  = "arn:aws:s3:::test-vpc-flow-log234"     #this vpc flow log bucket is already created in log archive account
    vpc_flow_log_name   = var.vpc_flow_log_config.vpc_flow_log_name
    traffic_type        = var.vpc_flow_log_config.traffic_type
  }
}

# resource "aws_s3_bucket_policy" "example" {
#   bucket = "mystatebucket9018"
#   policy = jsonencode({
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "GitHubActionsDeployerRole",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": [
#     "arn:aws:iam::407688908115:role/GitHubActionsDeployerRole",
#     "arn:aws:iam::407688908115:role/AWSReservedSSO_AWSAdministratorAccess_2403dc25de88e415/Admin_Muskan.Kesarwani@theermgroup.onmicrosoft.com"
#   ]
#       },
#       "Action": [
#         "s3:GetObject",
#         "s3:PutObject",
#         "s3:ListBucket"
#       ],
#       "Resource": [
#         "arn:aws:s3:::mystatebucket9018",
#         "arn:aws:s3:::mystatebucket9018/*"
#       ]
#     },
#     {
#       "Sid": "DenyNonHTTPS",
#       "Effect": "Deny",
#       "Principal": "*",
#       "Action": "s3:*",
#       "Resource": [
#         "arn:aws:s3:::mystatebucket9018",
#         "arn:aws:s3:::mystatebucket9018/*"
#       ],
#       "Condition": {
#         "Bool": {
#           "aws:SecureTransport": "false"
#         }
#       }
#     },
#     {
#       "Sid": "DenyAllExceptTerraformRole",
#       "Effect": "Deny",
#       "Principal": "*",
#       "Action": "s3:*",
#       "Resource": [
#         "arn:aws:s3:::mystatebucket9018",
#         "arn:aws:s3:::mystatebucket9018/*"
#       ],
#       "Condition": {
#         "StringNotEquals": {
#           "aws:PrincipalArn": [
#   "arn:aws:iam::407688908115:role/GitHubActionsDeployerRole",
#   "arn:aws:iam::407688908115:role/AWSReservedSSO_AWSAdministratorAccess_2403dc25de88e415/Admin_Muskan.Kesarwani@theermgroup.onmicrosoft.com"
# ]
#         }
#       }
#     }
#   ]
# })
# }