resource "aws_iam_role" "ecs-ec2-role" {
  name = join("", [var.name, "ecs-instance-role"])
  path = "/ecs/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "default" {
  name = join("", [var.name, "-ecs-instance-profile"])
  role = aws_iam_role.ecs-ec2-role.name
}

resource "aws_iam_policy" "ecs-discovery-policy" {
  name = "HazelcastECSDiscoveryPolicy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ecs:ListTasks",
                "ecs:DescribeTasks"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-ec2-container-service-policy-attachment" {
  role       = aws_iam_role.ecs-ec2-role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs-ec2-ssm-policy-attachment" {
  role       = aws_iam_role.ecs-ec2-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ecs-discovery-policy-attachment" {
  policy_arn = aws_iam_policy.ecs-discovery-policy.arn
  role       = aws_iam_role.ecs-ec2-role.id
}