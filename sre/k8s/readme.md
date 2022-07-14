# minikube
```
$ minikube start
$ minikube start --cpus 4 --memory 4096
$ minikube stop
$ minikube dashboard
$ minikube delete
$ minikube ip
$ minikube ssh
$ minikube config set memory 4096
$ minikube config set cpus 2
```
# context
```
$ kubectl config get-contexts
$ kubectl config current-context
$ kubectl config use-context minikube
$ kubectl cluster-info
```
# node
```
$ kubectl get nodes
```

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
# deploy
```
$ kubectl apply -f deploy.yaml
$ kubectl create -f deploy.yaml
$ kubectl delete -f deploy.yaml
$ kubectl get deploy
$ kubectl describe deploy ${deploy}
$ kubectl delete deploy ${deploy}
```
# service
```
$ kubectl apply -f svc.yaml
$ kubectl create -f svc.yaml
$ kubectl get svc
$ kubectl describe svc ${service}
$ kubectl delete svc ${service}
```
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
# persistentvolumes
```
$ kubectl apply -f pv.yaml
$ kubectl create -f pv.yaml
$ kubectl delete -f pv.yaml
$ kubectl get persistentvolumes
$ kubectl describe persistentvolumes ${pv}
$ kubectl delete persistentvolumes ${pv}
```
# persistentvolumeclaims
```
$ kubectl apply -f pvc.yaml
$ kubectl create -f pvc.yaml
$ kubectl delete -f pvc.yaml
$ kubectl get persistentvolumeclaims
$ kubectl describe persistentvolumeclaims ${pcv}
$ kubectl delete persistentvolumeclaims ${pvc}
```
# config
```
$ kubectl apply -f configmap.yaml
$ kubectl create -f configmap.yaml
$ kubectl delete -f configmap.yaml
$ kubectl get configmap
$ kubectl describe configmap ${configmap}
$ kubectl delete configmap ${configmap}
```
# replicaset
```
$ kubectl get replicatset
```