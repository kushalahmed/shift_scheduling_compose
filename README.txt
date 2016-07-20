Docker compose for shift_scheduling - https://github.com/kushalahmed/shift_scheduling

Setup Instructions:
===================

It is assumed that your host machine has Docker (version 1.10.3+) installed.

After downloading the source of this project, follow the steps below to spin up the shift scheduling and other services for the development environment:

    1. Go to the root folder of this project from a terminal, and change directory to 'load-balanced'.
    2. Execute: sh ./init-sources.sh (It will download the source of the shift_scheduling project)
    3. Execute: docker-machine start default (It starts the default docker machine)
    4. Execute: eval $(docker-machine env default) (It activates the default docker machine to work on)
    5. Execute: docker-compose -f development/development.yml up (It downloads/creates Docker images as necessary, and spins up the services)


The shift scheduling service will be available at http://<default machine ip>:80.

To scale up the shifts scheduling service, execute the following:
    docker-compose -f development/development.yml devshiftscheduling scale=20

To setup for the production environment, the steps are same, however the docker-compose commands will be the following:

    docker-compose -f production/production.yml up
    docker-compose -f production/production.yml prodshiftscheduling scale=20


To setup the services in the docker swarm clusters, follow the instructions below:

    1. Go to the root folder of this project from a terminal, and change directory to 'load-balanced'.
    2. Execute: sh ./init-sources.sh
    3. Execute: sh ./setup-clusters.sh (It will set up the swarm clusters, and activate the swarm head to work on. You may need to check/wait (execute: docker info) to see if the swarm clusters are up and running)
    4. Execute: docker-compose -f development/development.yml up

The shift scheduling service will be available at http://<swarm agent ip>:80, here the swarm agent is the one that hosts the HAProxy service (execute: docker ps).

Commands for setting up for the production environment and scaling up the service are the same.



