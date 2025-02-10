# Grafana
顯示metrics的UI Service，支援多種類型Data Source跟Dashboard

## Docker
### Renderer
```
docker run -d -p 18081:8081 -e BROWSER_TZ=Asia/Taipei --name=grafana-image-renderer grafana/grafana-image-renderer
```

### Grafana
```
docker run -d -p 13000:3000 -e GF_RENDERING_SERVER_URL=http://192.168.13.82:18081/render -e GF_RENDERING_CALLBACK_URL=http://192.168.13.82:13000/ -e GF_LOG_FILTERS=rendering:debug --name=grafana grafana/grafana 
```

## Reference
* https://github.com/880831ian/Prometheus-Grafana-Docker