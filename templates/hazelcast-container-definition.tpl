[
  {
    "name": "hazelcast",
    "image": "docker.io/hazelcast:${hazelcast_version}",
    "cpu": ${hazelcast_container_cpu},
    "memory": ${hazelcast_container_memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5701,
        "hostPort": 5701
      }
    ]
  }
]