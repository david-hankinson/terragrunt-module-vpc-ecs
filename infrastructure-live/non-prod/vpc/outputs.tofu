output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_ids" {
  value = module.vpc.private_subnet_ids[*].id
  #   value = aws_subnet.private[*].id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}