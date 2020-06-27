#!/bin/bash
set -x

echo 'ECS_CLUSTER=${cluster_name}' >> /etc/ecs/ecs.config

sed -i '/After=cloud-final.service/d' /usr/lib/systemd/system/ecs.service
systemctl daemon-reload

mkdir -p /home/ec2-user/hazelcast
touch /home/ec2-user/hazelcast/hazelcast.yaml
echo '${hazelcast_config}' >> /home/ec2-user/hazelcast/hazelcast.yaml

#verify that the agent is running
until curl -s http://localhost:51678/v1/metadata
do
	sleep 1
done

systemctl restart docker
systemctl restart ecs