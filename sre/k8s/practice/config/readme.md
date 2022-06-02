# config
最後用kubectl logs config-pod，可以看到CONFIG_EXAMPLE=v1
```
kubectl apply -f config.yaml
kubectl get configmap
kubectl describe configmap config-example
kubectl apply -f pod.yaml
kubectl get pods
kubectl logs config-pod
```