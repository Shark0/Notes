# Nginx JWT
## Build
```
docker build -t nginx-image:1.1 . 
```

## Run
```
docker run --name nginx-image -d -p 8080:80 nginx-image:1.1
```