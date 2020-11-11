#docker
## info
```
$ docker info
```
## image
```
$ docker search ${image}
$ docker pull ${image}
$ docker pull ${image}:${version}
$ docker rmi ${image}
$ docker rmi ${image}:${version}
$ docker save -o ${file}.tar ${image}
$ docker load -i ${file}.tar
```
## docker file
```
$ docker build -t ${image} . --no-cache
```
## container
```
$ docker create ${image}
$ docker create ${image}:${version}
$ docker start -n ${container_name} -p {port}:{container_port} ${image}
$ docker run --rm ${image}:${version}
$ docker run -d -v ${mount_destination}:${container_mount_destination} -n ${container_name} -p {port}:{container_port} ${image}:${version}
$ docker attach ${container_name}
$ docker cp ${file_path} ${container_name}:${container_file_path}
$ docker cp ${container_name}:${container_file_path} ${file_path} 
```
