# Nginx JWT
## Build
```
docker build -t nginx-jwt-image:1.1 . 
```

## Run
```
docker run --name nginx-jwt-image -d -p 8080:80 nginx-jwt-image:1.1
```