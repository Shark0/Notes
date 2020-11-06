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
$ kunectl apply -f pod.yaml
$ kunectl create -f pod.yaml
$ kunectl delete -f deploy.yaml
$ kubectl get po
$ kubectl get po --show-labels
$ kubectl describe po ${pod}
$ kubectl logs ${pod}
$ kubectl delete po ${pod}
$ kubectl -n ${namespace} exec -it ${pod} -- /bin/bash
```
# deploy
```
$ kunectl apply -f deploy.yaml
$ kunectl create -f deploy.yaml
$ kunectl delete -f deploy.yaml
$ kubectl get deploy
$ kubectl describe deploy ${deploy}
$ kubectl delete deploy ${deploy}
```
# service
```
$ kunectl apply -f svc.yaml
$ kunectl create -f svc.yaml
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
$ kunectl apply -f pv.yaml
$ kunectl create -f pv.yaml
$ kunectl delete -f pv.yaml
$ kubectl get persistentvolumes
$ kubectl describe persistentvolumes ${pv}
$ kubectl delete persistentvolumes ${pv}
```
# persistentvolumeclaims
```
$ kunectl apply -f pvc.yaml
$ kunectl create -f pvc.yaml
$ kunectl delete -f pvc.yaml
$ kubectl get persistentvolumeclaims
$ kubectl describe persistentvolumeclaims ${pcv}
$ kubectl delete persistentvolumeclaims ${pvc}
```
# config
```
$ kunectl apply -f configmap.yaml
$ kunectl create -f configmap.yaml
$ kunectl delete -f configmap.yaml
$ kubectl get configmap
$ kubectl describe configmap ${configmap}
$ kubectl delete configmap ${configmap}
```
# replicaset
```
$ kunectl get replicatset
```