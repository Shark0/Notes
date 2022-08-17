# namespace
```
$ kubectl create ns ${namespace}
$ kubectl get ns
$ kubectl describe ns
$ kubectl describe ns ${namespace}
$ kubectl delete ns ${namespace}
$ kubectl apply -f deploy.yaml -n ${namespace}
$ kubectl get deploy -n ${namespace}
$ kubectl apply -f pod.yaml -n ${namespace}
$ kubectl get pods -n ${namespace}
```