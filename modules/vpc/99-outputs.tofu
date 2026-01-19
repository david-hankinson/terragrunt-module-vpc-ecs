# modules/vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id  # or whatever your resource name is
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}