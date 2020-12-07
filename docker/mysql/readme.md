# Mysql
## command
```
$ docker run --name=mysql -d -p 3306:3306 -v D:\docker\volume\mysql:/var/lib/mysql -v D:\docker\volume\mysql_log:/tmp/log --env MYSQL_ROOT_PASSWORD=root mysql/mysql-server
```