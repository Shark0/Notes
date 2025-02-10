# Container

```
docker create $image
docker create $image:$version
docker start -n $container_name -p $port:$container_port $image
docker run --rm $image:$version
docker run -d -v $mount_destination:$container_mount_destination -e $key=$value --name=$container_name -p $port:$container_port $image:$version $command
docker attach $container_name
docker cp $file_path $container_name:$container_file_path
docker cp $container_name:$container_file_path $file_path 
```