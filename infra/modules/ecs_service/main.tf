resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = var.cluster
  task_definition = var.task_definition
  launch_type = "FARGATE"

  desired_count = var.desired_count

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups = var.security_groups
    subnets         = var.subnets
  }

  tags = {
    Name = var.service_name
  }
}