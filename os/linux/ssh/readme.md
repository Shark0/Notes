# SSH
## Setting SSH Key
### Create SSH Key
輸入以下指令，private跟public就會建立在~/.ssh裡
* private key: id_rsa
* public key: id_rsa.pub
```
ssh-keygen
```
### Add Public Key in Remote Server
取得public key內容
```
cat ~./ssh/id_rsa.pub
```
將Public Key內容貼到遠端電腦的authorized_keys檔案中
* 登入遠端電腦
```
ssh ${username}@${host}
```
* 貼上public key內容
```
vi ~./ssh authorized_keys
```

## SSH
```
ssh -p ${port} ${user_name}@${host} 
```
## SCP
### 將檔案從本地複製到遠端
```
scp ${local_file_path} ${user_name}@${host}:${remote_file_path}
```
### 將檔案從遠端複製到本地
```
scp ${user_name}@${ip}:${remote_file_path} ${local_file_path}
```