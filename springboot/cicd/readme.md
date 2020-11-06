# Spring Boot CI CD建置
在k8s minikube上建置springboot ci cd

# 安裝docker
網路太多案例，這裡不說明

# 安裝k8s
要能啟動minikube，網路太多案例，這裡不說明

# jenkins
## 安裝jenkins
將jenkins安裝在k8s
```
$ kubectl apply -f jenkins.yaml 
$ kubectl delete -f jenkins.yaml 
$ kubectl get pv
$ kubectl get pvc
$ kubectl get svc #要看配置port
$ kubectl get deploy
```
## 啟動jenkins
* 查minikube ip跟service port
```
$ minikube ip
$ kubectl get svc
```
* 打開jenkins
```
${minikube_ip}:${service_port}
```
* 取得initialAdminPassword
```
$ kubectl get pod
$ kubectl exec -it ${jenkins_pod_name} bash
$ cd /var/jenkins_home/secrets
$ cat initialAdminPassword #將password貼到jenkins getting started頁面中的Administrator password
```
## jenkins k8s 設定
* 點擊"管理jenkins"
* 點擊"管理外掛程式"
* 點擊"可用的"
* 搜尋"kubernetes" plugin
* 點擊安裝
* 回到"管理jenkins"
* 點擊"設定系統"
* 點擊最下方cloud
* 點擊新增雲
* kubernetes url輸入"https://kubernetes.default"
* jenkins url輸入"${minikube_ip}:${service_port}"
* 按save