data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data template_file "hazelcast_config" {
  template = file("${path.module}/templates/hazelcast.yaml.tpl")
  vars     = {
    region                        = var.region
    hazelcast_discovery_tag_key   = var.hazelcast_discovery_tag_key
    hazelcast_discovery_tag_value = var.tags[var.hazelcast_discovery_tag_key]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user-data.sh")
  vars     = {
    cluster_name     = var.name
    hazelcast_config = data.template_file.hazelcast_config.rendered
  }
}

resource "aws_instance" "hazelcast_instance" {
  count                  = var.instance_count
  ami                    = coalesce(var.ami_id, data.aws_ami.ecs.id)
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  iam_instance_profile   = aws_iam_instance_profile.default.id
  user_data              = data.template_file.user_data.rendered
  tags                   = var.tags
}

