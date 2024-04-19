## persistent volumes
```
$ kubectl apply -f pv.yaml
$ kubectl create -f pv.yaml
$ kubectl delete -f pv.yaml
$ kubectl get persistentvolumes
$ kubectl describe persistentvolumes ${pv}
$ kubectl delete persistentvolumes ${pv}
```