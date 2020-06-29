#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOUR='\033[0m'

# Deploy the multi-node example
echo -e "${YELLOW}Deploying the 'multi-node' example with Terraform${NO_COLOUR}"
cd ../examples/multi-node || exit
terraform apply -auto-approve

# Build client
echo -e "${YELLOW}Testing connection...${NO_COLOUR}"
cd ../../tests/hazelcast-java-client || exit
sleep 10

# Build the client docker image
echo -e "${YELLOW}Building the client docker image${NO_COLOUR}"
docker build -t 'local/hazelcast_client:latest' .

# Run the client image
echo -e "${YELLOW}Starting the client and verifying connection${NO_COLOUR}"
docker run --name 'hazelcast_client' local/hazelcast_client


# Members test
if docker logs hazelcast_client 2>&1 | grep -F --quiet 'Members [2]'; then
  echo -e "${GREEN}✓ Discovered all members in the cluster${NO_COLOUR}"
else
  echo -e "${RED}Could not discover all members!${NO_COLOUR}"
  exit
fi

# Connection test
if docker logs hazelcast_client 2>&1 | grep -F --quiet 'Connection Successful!'; then
  echo -e "${GREEN}✓ Client connection successful${NO_COLOUR}"
else
  echo -e "${RED}Client failed to connect!${NO_COLOUR}"
  exit
fi
