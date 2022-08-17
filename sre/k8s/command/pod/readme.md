# pod

```
$ kubectl apply -f pod.yaml
$ kubectl create -f pod.yaml
$ kubectl delete -f deploy.yaml
$ kubectl get pod
$ kubectl get pod --show-labels
$ kubectl describe pod ${pod}
$ kubectl logs ${pod}
$ kubectl delete pod ${pod}
$ kubectl -n ${namespace} exec -it ${pod} -- /bin/bash
```