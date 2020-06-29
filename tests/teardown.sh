#!/bin/bash

YELLOW='\033[0;33m'
NO_COLOUR='\033[0m'

# Destroy the multi-node example
echo -e "${YELLOW}Destroying the 'multi-node' example with Terraform${NO_COLOUR}"
cd ../examples/multi-node || exit
terraform destroy -auto-approve

# Remove docker containers
echo -e "${YELLOW}Removing Docker container 'hazelcast_client'${NO_COLOUR}"
docker stop hazelcast_client
docker rm hazelcast_client

# Remove docker images
echo -e "${YELLOW}Removing Docker image 'local/hazelcast_client'${NO_COLOUR}"
docker rmi 'local/hazelcast_client'
