[
  {
    "name": "hazelcast",
    "image": "hazelcast/hazelcast:${hazelcast_version}",
    "cpu": ${hazelcast_container_cpu},
    "memory": ${hazelcast_container_memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5701,
        "hostPort": 5701
      }
    ],
    "environment": [
      {
        "name": "JAVA_OPTS",
        "value": "-Dhazelcast.local.publicAddress=${instance_public_ip}:5701"
      }
    ]
  }
]