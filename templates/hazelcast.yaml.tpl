hazelcast:
  network:
    join:
      multicast:
        enabled: false
      aws:
        enabled: true
        region: ${region}
        tag-key: ${hazelcast_discovery_tag_key}
        tag-value: ${hazelcast_discovery_tag_value}