#!/bin/bash

# Levantar 4 contenedores
docker run -d --name nginx1 nginx

docker create --name mi_phpmyadmin -p 8080:80 phpmyadmin/phpmyadmin

docker run -d --name mysql1 -p 8002:80 mysql
docker kill mysql1

docker run -d --name node1 node
docker pause node1 

# Mostrar los contenedores con estado
docker ps -a