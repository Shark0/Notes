# Volume
## Resource
* [empty_volume.yaml](resource/empty_volume_pod.yaml)
* [host_path_pod.yaml](resource/host_path_pod.yaml)
* [nginx_pvc.yaml](resource/nginx_pvc.yaml)

## Example
### empty volume
emptyDir 依舊是屬於臨時性的目錄，當 Pod 被刪除的同時該目錄也會被刪除。
emptyDir 可以應用在
* 暫存空間
* 多個容器的共享空間
```
$ kubectl apply -f empty_volume_pod.yaml
$ kubectl exec -it empty-volume-example bash
```

### host path
使用 hostPath 可以指定一個 Node 的目錄掛載到 Pod 中使用，即便 Pod 被刪除，該目錄的內容也都會存在。
```
$ kubectl apply -f host_path_pod.yaml
$ kubectl exec -it host-path-example bash
$ echo "My Host Path" >> /tmp/conf/mypath
$ exit
$ minikube ssh
$ cat /tmp/hostpathdata/mypath
$ exit
```

### pv & pvc
#### pv status
* Available：表示 PV 為可用狀態
* Bound：表示已綁定到 PVC
* Released：PVC 已被刪除，但是尚未回收
* Failed：回收失敗
#### pv reclaim policy
* Retain：手動回收
* Recycle：透過刪除命令 rm -rf /thevolume/*
* Delete：用於 AWS EBS, GCE PD, Azure Disk 等儲存後端，刪除 PV 的同時也會一併刪除後端儲存磁碟。
    
```
$ kubectl apply -f nginx_pvc.yaml 
$ kubectl get persistentvolumes
$ kubectl get persistentvolumeclaims
$ kubectl get pod
$ kubectl exec -it pvc-pod bash
$ echo "My Host Path" >> /tmp/conf/mypath
$ exit

$ minikube ssh
```