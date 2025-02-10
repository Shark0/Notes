# Prometheus

## Docker
### Exporter
協助prometheus抓取個服務metrics

#### nginx
```
docker run -d -p 19113:9113 --name=promethus_exporter_nginx nginx/nginx-prometheus-exporter:latest --nginx.scrape-uri=http://192.168.13.82:18080/stub_status
```
可用這url測試 http://localhost:19113/metrics

### Prometheus
```
docker run -d -p 19090:9090 --name=prometheus -v ${pwd}/prometheus.yaml:/etc/prometheus/prometheus.yaml prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yaml
```

## Reference
* https://github.com/880831ian/Prometheus-Grafana-Docker/tree/master