# Network
## Find Port
```
$ netstat -aon | grep ${port_number}
```
## Close Port
```
taskkill /f /im {pid}
```

## Netsh
* https://docs.microsoft.com/zh-tw/windows-server/networking/technologies/netsh/netsh-contexts

## Open Firewall
```
netsh advfirewall firewall add rule name="${role_name}" protocol=TCP dir=in localport=${port} action=allow
netsh advfirewall firewall add rule name="${role_name}" protocol=UDP dir=in localport=${port} action=allow
```