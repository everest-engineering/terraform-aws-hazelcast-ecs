resource "aws_ecs_cluster" "hazelcast_ecs" {
  name = var.name
  tags = var.tags
}

data "template_file" "container_definition" {
  template = file("${path.module}/templates/hazelcast-container-definition.tpl")

  vars = {
    hazelcast_version          = var.hazelcast_version
    hazelcast_container_cpu    = var.hazelcast_container_cpu
    hazelcast_container_memory = var.hazelcast_container_memory
  }
}

resource "aws_ecs_task_definition" "hazelcast_task" {
  container_definitions    = data.template_file.container_definition.rendered
  family                   = var.name
  network_mode             = "host"
  requires_compatibilities = ["EC2"]
  tags                     = var.tags
  volume {
    name      = "hazelcast_config"
    host_path = "/home/ec2-user/hazelcast"
  }
}

resource "aws_ecs_service" "hazelcast_ecs_service" {
  name                               = var.name
  cluster                            = aws_ecs_cluster.hazelcast_ecs.arn
  task_definition                    = aws_ecs_task_definition.hazelcast_task.arn
  desired_count                      = var.hazelcast_members_count
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  launch_type                        = "EC2"
}