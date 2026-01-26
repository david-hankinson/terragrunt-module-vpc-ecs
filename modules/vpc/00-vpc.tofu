resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  // enable a vpc endpoint for s3 and private subnets
 
  region = var.region
  tags = {
    name = "${var.env}-vpc"
  }
}
