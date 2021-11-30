# Zabbix

## Install Zabbix Server
### Download docker-compose.yaml From Git
```
git clone https://github.com/zabbix/zabbix-docker
```
### Install docker-compose.yaml
```
cd zabbix-docker
docker-compose -f ./docker-compose_v3_centos_pgsql_latest.yaml up -d
```

remove docker-compose command
```
docker-compose -f ./docker-compose_v3_centos_pgsql_latest.yaml stop
docker-compose -f ./docker-compose_v3_centos_pgsql_latest.yaml rm
```

## Install Windows Agent
* download Agent2: https://www.zabbix.com/download_agents
* install
* open firewall
```
netsh advfirewall firewall add rule name=" Zabbix_Agent_TCP(10050) Port" protocol=TCP dir=in localport=10050 action=allow

netsh advfirewall firewall add rule name=" Zabbix_Agent_UDP(10050) Port" protocol=UDP dir=in localport=10050 action=allow
```

## Setting Windows Agent 
* Click "Configuration"
* Click "Host"
* Click "Create host"
* Input "Host name"
* Select Groups "Templates/Operating systems"
* Add Interface "Agent"
* Click "Templates" Tab
* Link new templates "Windows by zabbix agent"
* Click "Add"

## Setting Telegram Media
* Click "Administration"
* Click "Telegram"
* Input Token Value
* Click "Update"

## Setting Users Media
* Click "Administration"
* Click "Users"
* Click "Admin" User
* Click "Media"
* Click "Add"
* Select Type "Telegram"
* Input "Telegram Channel Id" to "Send to"
* Click "Add"
* Click "Update"