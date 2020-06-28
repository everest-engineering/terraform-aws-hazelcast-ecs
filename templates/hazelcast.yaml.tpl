hazelcast:
  network:
    join:
      multicast:
        enabled: false
      aws:
        host-header: ec2
        region: ${region}
        enabled: true
        tag-key: ${hazelcast_discovery_tag_key}
        tag-value: ${hazelcast_discovery_tag_value}