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
    "mountPoints": [
      {
         "containerPath": "/opt/hazelcast/config_ext",
         "sourceVolume": "hazelcast_config"
      }
    ],
    "environment": [
      {
        "name": "JAVA_OPTS",
        "value": "-Dhazelcast.config=/opt/hazelcast/config_ext/hazelcast.yaml"
      }
    ]
  }
]