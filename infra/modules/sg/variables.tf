variable "name_prefix" {
  type        = string
  description = "The prefix name for the security group"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to associate the security group with"
}

variable "ingress_rules" {
  type        = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = {}
  description = "Map of ingress rules to create"
}

variable "egress_rules" {
  type        = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = {}
  description = "Map of egress rules to create"
}