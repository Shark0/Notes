# Nginx JWT
## Build
```
docker build -t nginx-jwt:1.1 . 
```

## Run
```
docker run --name nginx-jwt -d -p 8080:80 -e KEY='Shark' -v ./config/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v ./html:/usr/local/openresty/nginx/html nginx-jwt:1.1
```