#docker
## image
```
docker pull ${image}
docker pull ${image}:${version}
docker rmi ${image}
docker rmi ${image}:${version}
docker save -o ${file}.tar ${image}
docker load -i ${file}.tar
```
## docker file
```
docker build -t ${image} . --no-cache
```
## container
```
docker create ${image}
docker create ${image}:${version}
docker start -n ${container-name} -p {port}:{container-port} ${image}
docker run --rm ${image}:${version}
docker run -d -v ${mount-destination}:${container-mount-destination} -n ${container-name} -p {port}:{container-port} ${image}:${version}
```
