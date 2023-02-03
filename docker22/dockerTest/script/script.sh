#!/bin bash

docker container prune -f & docker ps -a

# Levantar 5 contenedores
echo "Lenzamos un contenedor que  quede en un estado de Up"
docker run -d --name container1 -p 8080:80 ubuntu:latest

echo "Levantamos un contenedor que quede en un estado de Restarting"
docker run --restart=always --name container2 ubuntu:latest 
docker exec container2 bash 
bash -c exit
# docker restart container2 --restart=always

echo "Levantamos un contenedor que quede en un estado de created"
docker create --name container3 ubuntu:latest

echo "Levantamos un contenedor que quede en un estado de exited"
docker run -d --name container4 ubuntu:latest 
docker kill container4
echo "Levantamos un contenedor que quede en un estado de paused"
docker run -d --name container5 ubuntu:latest sleep 1
docker pause container5

# Mostrar los contenedores con estado
docker ps -a

echo "Finalizamos los contenedores"

# parar todos los contenedores
docker stop $(docker ps -a -q)

# borra todos los contenedores
docker rm $(docker ps -a -q)
docker container prune -fa

# Mostrar si hay contenedores 
docker ps -a