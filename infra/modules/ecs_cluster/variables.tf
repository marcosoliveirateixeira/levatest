variable "cluster_name" {
  type        = string
  description = "The name for the ECS cluster"
}

variable "capacity_providers" {
  type        = list(string)
  default     = []
  description = "The capacity providers to associate with the ECS cluster"
}