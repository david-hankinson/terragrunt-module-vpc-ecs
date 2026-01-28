module "vpc" {
  source = "../../../modules/vpc"

  env                  = "prod"
  availability_zones   = ["ca-central-1a", "ca-central-1b"]
  cidr_block           = "10.100.0.0/16"
  private_subnets      = ["10.100.1.0/24", "10.100.2.0/24"]
  public_subnets       = ["10.100.11.0/24", "10.100.12.0/24"]
  region               = "ca-central-1"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

provider "aws" {
  region = "ca-central-1"
  assume_role {
    role_arn = "arn:aws:iam::754417747438:role/organizationAdminRole"
  }
}

terraform {
  backend "s3" {
    bucket       = "terragrunt-vpc-ecs-state-demo"
    key          = "prod/terraform.tfstate"
    region       = "ca-central-1"
    use_lockfile = true
    encrypt      = true
    # role_arn = "arn:aws:iam::754417747438:role/organizationAdminRole"
  }
}

# VPC 2	Prod	10.20.0.0/16	Main Prod Network
# Subnet 1	Prod	10.20.1.0/24	Public Subnet A
# Subnet 2	Prod	10.20.2.0/24	Public Subnet B
# Subnet 3	Prod	10.20.10.0/24	Private Subnet A
# Subnet 4	Prod	10.20.11.0/24	Private Subnet B