hazelcast:
  network:
    join:
      multicast:
        enabled: false
      aws:
        region: ${region}
        enabled: true
        tag-key: ${hazelcast_discovery_tag_key}
        tag-value: ${hazelcast_discovery_tag_value}