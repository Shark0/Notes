#!/bin/bash

docker stop nginx-image
docker rm nginx-image
docker rmi nginx-image:1.1
docker build -t nginx-image:1.1 .
docker run --name nginx-image -d -p 8080:80 nginx-image:1.1