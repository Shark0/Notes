# SSH
## Create SSH Key
輸入以下指令，private跟public就會建立在~/.ssh裡
* private key: id_rsa
* public key: id_rsa.pub
```
$ ssh-keygen
```
## Add Public Key in Remote Server
取得public key內容
```
$ cat ~./ssh/id_rsa.pub
```
將Public Key內容貼到遠端電腦的authorized_keys檔案中
```
# 登入遠端電腦
$ vi ~./ssh authorized_keys
# 貼上public key內容
```