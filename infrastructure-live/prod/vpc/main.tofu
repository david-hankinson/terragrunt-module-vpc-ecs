// TODO - MODIFY THIS FILE THAT SO IT CONTAINS DIFFERENT VARIABLES. MAKE A COMMIT SHOWING THAT WE'RE REPEATING OURSELVES HERE ACROSS ENIVRONMENTS.

resource "aws_vpc" "this" {
  cidr_block = "10.1.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  // enable a vpc endpoint for s3 and private subnets

  tags = {
    name = "dev-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.this.id
  cidr_block              = ["10.1.1.0/24", "10.1.2.0/24"][count.index]
  availability_zone       = ["ca-central-1a", "ca-central-1b"][count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = ["10.1.3.0/24", "10.1.4.0/24"][count.index]
  availability_zone = ["ca-central-1a", "ca-central-1b"][count.index]
  #map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}

############ OUTPUTS ############

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}
