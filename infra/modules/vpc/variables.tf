variable "cidr_block" {
  type = string
  description = "The CIDR block for the VPC"
}

variable "name" {
  type = string
  description = "The name of the VPC"
}

variable "private_subnet_count" {
  type = number
  description = "The number of private subnets to create"
}

variable "public_subnet_count" {
  type = number
  description = "The number of public subnets to create"
}