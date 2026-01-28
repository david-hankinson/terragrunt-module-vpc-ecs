# module "vpc" {
#   source = "../../../modules/vpc"

#   env                  = "non-prod"
#   cidr_block           = "10.50.0.0/16"
#   availability_zones   = ["ca-central-1a", "ca-central-1b"]
#   private_subnets      = ["10.50.1.0/24", "10.50.2.0/24"]
#   public_subnets       = ["10.50.11.0/24", "10.50.12.0/24"]
#   region               = "ca-central-1"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
# }

# provider "aws" {
#   region = "ca-central-1"
#   assume_role {
#     role_arn = "arn:aws:iam::596596146882:role/organizationAdminRole"
#   }
# }

# terraform {
#   backend "s3" {
#     bucket       = "terragrunt-vpc-ecs-state-demo-childaccount2"
#     key          = "non-prod/terraform.tfstate"
#     region       = "ca-central-1"
#     use_lockfile = true
#     encrypt      = true
#     # role_arn = "arn:aws:iam::596596146882:role/organizationAdminRole"
#   }
# }
