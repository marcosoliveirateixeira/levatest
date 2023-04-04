resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  capacity_providers = var.capacity_providers

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_name
  }
}