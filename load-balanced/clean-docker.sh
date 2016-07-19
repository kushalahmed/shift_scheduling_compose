#!/bin/bash

eval $(docker-machine env --swarm swarm-head)

docker stop $(docker ps -q)
docker rm -f $(docker ps -q)
#docker rmi $(docker images -q)