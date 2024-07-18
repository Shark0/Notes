# Nginx JWT
## Build
```
docker build -t nginx-encode:1.1 . 
```

## Run
```
docker run --name nginx-encode -d -p 8080:80 nginx-encode:1.1
```