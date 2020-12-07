# Database

## Start
```
$ docker run --name=card_sql -p 3306:3306 -d --env MYSQL_ROOT_PASSWORD=Woainiqipai123$%^ mysql:5.7 --lower-case-table-names
$ docker cp card.sql card_sql:/root/card.sql
$ docker exec -it card_sql bin/bash
$ mysql -u root -pWoainiqipai123$%^ < /root/card.sql 
```