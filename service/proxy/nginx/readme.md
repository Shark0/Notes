# Nginx
## CORS
最近在架環境碰到CORS，看了這篇文章終於弄到有點概念，簡單講就是Server決定好非簡單請求的Client限制，如果Client沒乖乖遵守就會出現CORS問題。
https://shubo.io/what-is-cors/

但是如果該Client非你處裡的，是可以透過Nginx設定來處理Cors

```
location /${example_path }{
    if ($request_method = OPTIONS ) {
        add_header Access-Control-Allow-Origin $http_origin;
        add_header Access-Control-Allow-Methods "OPTIONS";
        add_header Access-Control-Allow-Credentials "true";
        add_header 'Access-Control-Allow-Headers' '*, content-type, ${custom_header}';
        add_header Content-Length 0;
        add_header Content-Type text/plain;
        return 200;
    }
	add_header 'Access-Control-Allow-Origin' $http_origin;
	add_header 'Access-Control-Allow-Credentials' 'true';
	add_header 'Access-Control-Allow-Methods' 'POST, GET, OPTIONS, PUT, DELETE';
	add_header 'Access-Control-Allow-Headers' '*, content-type, ${custom_header}';
	proxy_set_header Host $http_host;
	proxy_set_header Cookie $http_cookie;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Forwarded-Proto $scheme;
	proxy_pass http://${proxy_pass_host}/${api_path};
}
```