#!/bin/bash

docker stop nginx-encode
docker rm nginx-encode
docker rmi nginx-encode:1.1
docker build -t nginx-encode:1.1 .
docker run --name nginx-encode -d -e KEY='PUBLIC_KEY' -p 8081:80 nginx-encode:1.1