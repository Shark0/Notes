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
netsh advfirewall firewall add rule name="Rule Name" protocol=TCP dir=in localport=10050 action=allow
netsh advfirewall firewall add rule name="Rule Name" protocol=UDP dir=in localport=10050 action=allow
```