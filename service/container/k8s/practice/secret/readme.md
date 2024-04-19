# Secret
## Resource
* [pod.yaml](resource/pod.yaml)
* [secret.yaml](resource/secret.yaml)
## Command
```
$ kubectl create ns redis
$ kubectl apply -f secret.yaml -n redis
$ kubectl apply -f pod.yaml -n redis
$ kubectl -n redis exec -it redis-pod -- /bin/bash
$ echo ${SECRET_PASSWORD}
$ echo ${SECRET_USERNAME}
```