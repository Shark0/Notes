## persistent volume claims
```
$ kubectl apply -f pvc.yaml
$ kubectl create -f pvc.yaml
$ kubectl delete -f pvc.yaml
$ kubectl get persistentvolumeclaims
$ kubectl describe persistentvolumeclaims ${pcv}
$ kubectl delete persistentvolumeclaims ${pvc}
```