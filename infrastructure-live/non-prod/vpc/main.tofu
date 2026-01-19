module "vpc" {
  source = "../../../modules/vpc"

  env                  = "non-prod"
  cidr_block           = "10.10.0.0/16"
  availability_zones   = ["ca-central-1a", "ca-central-1b"]
  private_subnets      = ["10.10.10.0/24", "10.10.11.0/24"]
  public_subnets       = ["10.10.1.0/24", "10.10.2.0/24"]
  region               = "ca-central-1"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::754417747438:role/organizationAdminRole"
  }
}

terraform {
  backend "s3" {
    bucket         = "terragrunt-vpc-ecs-state-demo"
    key            = "non-prod/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "tofu-state-locking"
    encrypt        = true
  }
}


# VPC 1	Non-Prod	10.10.0.0/16	Main Non-Prod Network
# Subnet 1	Non-Prod	10.10.1.0/24	Public Subnet A
# Subnet 2	Non-Prod	10.10.2.0/24	Public Subnet B
# Subnet 3	Non-Prod	10.10.10.0/24	Private Subnet A
# Subnet 4	Non-Prod	10.10.11.0/24	Private Subnet B

# UPDATE THE MODULE INPUTS
# CREATE AN S3 BUCKET IN EACH OF THE ACCOUNTS
# ADD THE AWS ACCOUNT NUMBER, ROLE AND S3 BUCKET INTO THE PROVIDER
# SHOW THAT TOFU WILL MIGRATE STATE FROM COMMAND LINE

# HOW TO TEST TOFU MODULES? 

# TERRAGRUNTISATION