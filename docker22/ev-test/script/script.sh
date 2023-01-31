#!/bin/bash

# Levantar 5 contenedores
docker run -d --name 
docker restart ubuntu0 --restart=always

docker run -d --name ubuntu1 ubuntu:latest

docker create --name ubuntu2 ubuntu:latest

docker run -d --name ubuntu3 ubuntu:latest
docker kill ubuntu3

docker run -d --name ubuntu4 ubuntu:latest
docker pause ubuntu4

# Mostrar los contenedores con estado
docker ps -a

# Mostrar los contenedores con estado y su estado
# docker ps -a --format "table {{.Names}}\t{{.Status}}"
# docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
# docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}"
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\t{{.RunningFor}}"

# borra todos los contenedores
docker rm $(docker ps -a -q)

# Mostrar si hay contenedores 
docker ps -a