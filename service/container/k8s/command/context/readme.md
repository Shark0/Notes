# context
## Normal Command
```
$ kubectl config get-contexts
$ kubectl config current-context
$ kubectl config use-context minikube
$ kubectl cluster-info
```
## Set Context 
### Windows
```
$env:KUBECONFIG="{dir_path}\{your_config_filename}"
kubectl config set-context --current
```