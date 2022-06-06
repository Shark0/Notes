# Command
## Net
### Find Port
```
$ netstat -aon | grep ${port_number}
```
### Close Port
```
taskkill /f /im {pid}
```

### Netsh
* https://docs.microsoft.com/zh-tw/windows-server/networking/technologies/netsh/netsh-contexts
#### Open Firewall
```
netsh advfirewall firewall add rule name="${role_name}" protocol=TCP dir=in localport=${port} action=allow
netsh advfirewall firewall add rule name="${role_name}" protocol=UDP dir=in localport=${port} action=allow
```

## Service
* create service
```
SC CREATE Redis_Customer obj= "NT AUTHORITY\NetworkService" start= auto DisplayName= "${service_name}" binPath= "${service_exe_path}"
```
* stop service
```
SC STOP ${service_name}
```
* delete service
```
SC DELETE ${service_name}
```