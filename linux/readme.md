# 指令筆記
## User
```
$ adduser ${user}
$ userdel -r ${user}
$ passwd ${user} 
$ su ${user}
```
## Group
```
$ sudo groupadd ${group}
$ usermod -a -G wheel ${user} #wheel群組可以用sudo
$ usermod -a -G ${group1},${group2},${group3} ${user} 
```

## Tar
```
$ tar -cv ${file}.tar ${file} #壓縮
$ tar -xv ${file}.tar ${file} #解壓縮
```

## Env
```
$ env
$ set
$ export
$ export ${name}=${value}
$ unset ${name}
$ PATH=${PATH}:${bin_path}
$ $? #上一個指令的回傳值
$ var[1]=${value1}
$ var[2]=${value2}
$ var[3]=${value3}
$ echo "${var[1]}, ${var[2]}, ${var[3]}"
$ source ~/.bashrc #讀入環境設定檔
$ alias #指令別名
```
