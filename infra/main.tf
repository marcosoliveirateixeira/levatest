provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXIS2FNWK6KFVQSW2"
  secret_key = "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"
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = "192.168.0.0/24"
  name                 = "LevvaTest"
  private_subnet_count = 1
  public_subnet_count  = 1
}

module "security_group" {
  source = "./modules/sg"
  egress_rules = {
    HTTP = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  ingress_rules = {
    SSH = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    HTTP = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    TEST = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  name_prefix = "Liberate All"
  vpc_id      = module.vpc.vpc_id
}

module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = "LevvaTest"
}

module "ecs_service" {
  source = "./modules/ecs_service"
  cluster = module.ecs_cluster.cluster_name
  container_name = module.ecs_cluster.cluster_name
  container_port = 80
  security_groups = [module.security_group.id]
  service_name = module.ecs_cluster.cluster_name
  subnets = module.vpc.public_subnet_ids
  task_definition = aws_ecs_task_definition.main.arn
  assign_public_ip = true
}

resource "aws_ecr_repository" "my_ecr" {
  name = "levvatest"
}

resource "aws_ecs_task_definition" "main" {
    family = "service"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    memory = "512"
    cpu    = "256"  
    container_definitions = jsonencode([
      {
        name      = "my-container"
        image     = "nginx:latest"
        portMappings = [
          {
            containerPort = 80
            hostPort      = 80
            protocol      = "tcp"
          }
        ]
      }
    ])
}