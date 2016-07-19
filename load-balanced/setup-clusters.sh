#!/usr/bin/env bash

# 1. Setting up kv store
docker-machine create -d virtualbox kvstore
docker $(docker-machine config kvstore) run -d --net=host progrium/consul --server -bootstrap-expect 1

# Store the IP address of the kvstore machine
kvip=$(docker-machine ip kvstore)

# 2. Creating swarm master and 2 agents
# Source: https://gist.github.com/cpuguy83/79ad11aaf8e78c40ca71
docker-machine create -d virtualbox \
    --engine-opt "cluster-store consul://${kvip}:8500" \
    --engine-opt "cluster-advertise eth1:2376" \
    --swarm \
    --swarm-master \
    --swarm-image swarm:1.2.3 \
    --swarm-discovery consul://${kvip}:8500 \
    swarm-head

docker-machine create -d virtualbox \
      --engine-opt "cluster-store consul://${kvip}:8500" \
      --engine-opt "cluster-advertise eth1:2376" \
      --swarm \
      --swarm-image swarm:1.2.3 \
      --swarm-discovery consul://${kvip}:8500 \
      swarm-agent-01

docker-machine create -d virtualbox \
      --engine-opt "cluster-store consul://${kvip}:8500" \
      --engine-opt "cluster-advertise eth1:2376" \
      --swarm \
      --swarm-image swarm:1.2.3 \
      --swarm-discovery consul://${kvip}:8500 \
      swarm-agent-02

# 3. Set the docker environment to swarm master
eval $(docker-machine env --swarm swarm-head)

# 4. Stop the default one
docker-machine stop default