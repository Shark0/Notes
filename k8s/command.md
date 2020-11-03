# context
```
kubectl config get-contexts
kubectl config current-context
kubectl config use-context minikube
kubectl cluster-info

```
# minikube
```
minikube start
minikube dashboard
minikube delete
minikube ip
```
# pod
```
kunectl apply -f pod.yaml
kunectl create -f pod.yaml
kubectl get po
kubectl get po --show-labels
kubectl describe po ${pod}
kubectl logs ${pod}
kubectl delete po ${pod}
```
# deploy
```
kunectl apply -f deploy.yaml
kunectl create -f deploy.yaml
kubectl get deploy
kubectl describe deploy ${deploy}
kubectl delete deploy ${deploy}
```
# service
```
kunectl apply -f svc.yaml
kunectl create -f svc.yaml
kubectl get svc
kubectl describe svc ${service}
kubectl delete svc ${service}
```
# namespace
```
kubectl create ns ${namespace}
kubectl get ns
kubectl describe ns
kubectl describe ns ${namespace}
kubectl delete ns ${namespace}
kubectl apply -f deploy.yaml -n ${namespace}
kubectl get deploy -n ${namespace}
kubectl apply -f pod.yaml -n ${namespace}
kubectl get pods -n ${namespace}
```