# Card Docker
## Build Container
* build image
```
docker build -t card_server . 
docker run docker run --privileged=true -itd --name=card_server -p 30050:30050 -p 55555:55555 shark_card_server /sbin/init
```