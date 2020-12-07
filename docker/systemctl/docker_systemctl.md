# Card Docker
## Build Container
* build image
```
docker build -t systemctl_example . 
docker run docker run --privileged=true -itd --name=systemctl_example systemctl_example /sbin/init
```