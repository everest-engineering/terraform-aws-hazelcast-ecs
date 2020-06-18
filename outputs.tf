output "instance_public_ip" {
  description = "Public IP of the ECS EC2 instance"
  value = aws_instance.hazelcast-instance.public_ip
}