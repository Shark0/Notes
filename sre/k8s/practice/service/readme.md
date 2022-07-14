# Service and Ingress
* [官網教學](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/ingress-minikube/)

## Service
### Apply
```
$ kubectl apply -f svc.yaml 
$ kubectl get svc
$ kubectl apply -f deploy.yaml
$ kubectl get deploy
$ kubectl describe svc nginx
```
### Test
```
$ minikube ip
$ curl http://${minikube_ip}:30080
```

## Ingress
### Apply
```
$ minikube addons enable ingress
$ kubectl apply -f ingress.yaml
$ kubectl get ing
```