# Roll Update
## Resource
* [deployment.yaml](resource/deployment.yaml)

## Command
### 第一次部署
將deploy.yaml的spec.replicas改成3
```
$ kubectl apply -f deploy.yaml 
$ kubectl get deploy
$ kubectl get replicaset 
```
### 測試roll update
將deploy.yaml的spec.template.spec.container.image的nginx:1.14.2改成nginx:1.19.3
```
$ kubectl apply -f deploy.yaml 
$ kubectl get deploy
$ kubectl get replicaset 
$ kubectl rollout history deployment roll-deploy
$ kubectl rollout undo deployment roll-deploy
$ kubectl rollout undo deployment roll-deploy --to-revision=1
```