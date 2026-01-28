include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules//vpc/"
}

inputs = {
  env                  = "non-prod"
  cidr_block           = "10.50.0.0/16"
  availability_zones   = ["ca-central-1a", "ca-central-1b"]
  private_subnets      = ["10.50.1.0/24", "10.50.2.0/24"]
  public_subnets       = ["10.50.11.0/24", "10.50.12.0/24"]
  region               = "ca-central-1"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

remote_state {
  backend = "s3" 
  config = {
    bucket       = "terragrunt-vpc-ecs-state-demo-childaccount2"
    key          = "${path_relative_to_include()}/non-prod/terraform.tfstate"
    # role_arn = "arn:aws:iam::754417747438:role/organizationAdminRole"
  }
}