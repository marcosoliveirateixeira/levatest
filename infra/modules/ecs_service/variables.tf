variable "service_name" {
  type        = string
  description = "The name for the ECS service"
}

variable "cluster" {
  type        = string
  description = "The name of the ECS cluster to run the service in"
}

variable "task_definition" {
  type        = string
  description = "The task definition to use for the ECS service"
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "The desired number of tasks to run for the ECS service"
}

variable "container_name" {
  type        = string
  description = "The name of the container to associate with the ECS service"
}

variable "container_port" {
  type        = number
  description = "The port number on the container to associate with the ECS service"
}

variable "security_groups" {
  type        = list(string)
  description = "The security groups to associate with the network configuration of the ECS service"
}

variable "subnets" {
  type        = list(string)
  description = "The subnets to associate with the network configuration of the ECS service"
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign public ip choose"
}