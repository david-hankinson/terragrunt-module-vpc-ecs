module "vpc" {
  source = "../../../modules/vpc"

  env = "non-prod"
  availability_zones = [ "ca-central-1a", "ca-central-1b" ]
  private_subnets = [  ]
  public_subnets = [  ]
  region = "ca-central-1"
  cidr_block = ""
  enable_dns_hostnames = true
  enable_dns_support = true
}