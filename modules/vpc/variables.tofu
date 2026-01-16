variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "environment name"
  type        = string
}

variable "cidr_block" {
  description = "cidr block for the vpc"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "boolean expression to turn on or off dns_hostnames in your vpc"
  type        = bool
}

variable "enable_dns_support" {
  description = "boolean expression to turn on or off dns_hostnames in your vpc"
  type        = bool
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}
variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

