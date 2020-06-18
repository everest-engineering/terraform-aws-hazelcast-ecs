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
    instance_public_ip         = aws_instance.hazelcast-instance.public_ip
  }
}

resource "aws_ecs_task_definition" "hazelcast_task" {
  container_definitions    = data.template_file.container_definition.rendered
  family                   = var.name
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  tags                     = var.tags
}

resource "aws_ecs_service" "hazelcast_ecs_service" {
  name                               = var.name
  cluster                            = aws_ecs_cluster.hazelcast_ecs.arn
  task_definition                    = aws_ecs_task_definition.hazelcast_task.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  launch_type                        = "EC2"
}