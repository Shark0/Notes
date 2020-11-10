# Spring Boot CI CD建置
在k8s minikube上建置springboot ci cd，主要參考這篇部落格 https://www.qikqiak.com/k8s-book/docs/36.Jenkins%20Slave.html

## 安裝docker
網路太多案例，這裡不說明

## 安裝k8s
要能啟動minikube，網路太多案例，這裡不說明

## jenkins Slave
### 安裝jenkins
將jenkins安裝在k8s
```
$ kubectl create ns kube-ops
$ kubectl apply -f jenkins.yaml  
$ kubectl get pv
$ kubectl get pvc
$ kubectl get svc #要看配置port
$ kubectl get deploy
```
### 啟動jenkins
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
$ cat initialAdminPassword
```
* 將password貼到jenkins getting started頁面中的Administrator password
### Jenkins k8s 設定
* 點擊"管理jenkins"
* 點擊"管理外掛程式"
* 點擊"可用的"
* 搜尋"kubernetes" plugin
* 點擊安裝
* 回到"管理jenkins"
* 點擊"設定系統"
* 點擊最下方"Cloud"
* 點擊新增雲
* 點擊"Kubernetes Cloud details..."
* Kubernetes URL輸入"https://kubernetes.default.svc.cluster.local"
* Kubernetes Namespace輸入"kube-ops"
* jenkins url輸入"http://jenkins.kube-ops.svc.cluster.local:8080"，jenkins是service account，kube-ops是namespace
* 點擊"Pod Template..."
* Pod Template的name輸入"maven-jnlp"
* 點擊"Pod Template detail..."
* Pod Template的Namespace輸入"kube-ops"
* Pod Template的Labels輸入"maven-jnlp"
* 點擊"Add Container"選Container Template
* Container Template的Name輸入"jnlp"，改別的會出錯，很奇妙
* Container Template的Docker image輸入"shark0/maven-jenkins-slave:latest"
* Container Template的Working directory保持"/home/jenkins/agent"
* 刪除Container Template的Command to run
* 刪除Container Template的Arguments to pass to the command
* 點擊"Add Volume"選"Host Path"
* Host path輸入"/var/run/docker.sock"
* Mount path輸入"/var/run/docker.sock"
* 點擊"Add Volume"選"Host Path"
* Host path輸入"/root/.kube"
* Mount path輸入"/root/.kube"
* Service Account輸入"jenkins"
* 按Save

### 測試Jenkins Slave
* 點擊"新增作業"
* Enter an item name輸入"maven-jenkins-slave"
* 點擊"建立Free-Style軟體專案"，點擊下方"OK"
* 標籤表示式輸入"maven-jnlp"
* 點擊"新增建置步驟"選擇"執行 Shell"，輸入下方內容
```
echo "Kubernete Jenkins Slave"
docker info
mvn -version
kubectl get pods
```
* 按儲存
* 按"馬上建置"，看結果是否成功

### 建置docker hub Crendentials
* 點擊"管理Jenkins"
* 點擊"Manage Crendentials"
* 點擊"Jenkins"
* 點擊"Global crendentials (unrestricted)"
* 點擊"Add Credentials"
* Kind選擇"Username with password"
* Username輸入你的Docker Hub User
* Password輸入你的Docker Hub Password
* ID輸入"dockerhub"
* 點擊"OK"

### 建置springboot pipeline
* 點擊"新增作業"
* Enter an item name輸入"springboot example"
* 點擊"Pipeline"，點擊下方"OK"
* 在Pipeline Script輸入以下內容
```
node('maven-jnlp') {
    stage('Clone') {
        echo "Clone Stage"
        git url: "https://github.com/Shark0/SpringBootExample.git"
        script {
			build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    	}
    }
    stage('Build') {
      echo "Build Stage"
      sh "mvn clean package -DskipTests"
      sh "docker build -t shark0/springboot-example:${build_tag} ."
    }
    stage('Push') {
        echo "Push Docker Image Stage"
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerhubPassword', usernameVariable: 'dockerhubUser')]) {
            sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
            sh "docker push shark0/springboot-example:${build_tag}"
        }
    }
    stage('YAML') {
        echo "Change YAML File Stage"
        sh "sed -i 's/<BUILD_TAG>/${build_tag}/' k8s.yaml"
        sh "sed -i 's/<BRANCH_NAME>/${env.BRANCH_NAME}/' k8s.yaml"
    }
    stage('Deploy') {
      echo "Deploy Stage"
      sh "kubectl apply -f k8s.yaml"
    }
}
```
* 點擊"儲存"
* 點擊"馬上建置"