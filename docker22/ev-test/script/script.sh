#!/bin/bash

# Levantar 5 contenedores
docker run -d --name ubuntu0 ubuntu:latest
docker restart ubuntu0 --restart=always

docker run -d --name ubuntu1 ubuntu:latest

docker create --name ubuntu2 ubuntu:latest

docker run -d --name ubuntu3 ubuntu:latest
docker kill ubuntu3

docker run -d --name ubuntu4 ubuntu:latest
docker pause ubuntu4

# Mostrar los contenedores con estado
docker ps -a