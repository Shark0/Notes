# Practice

## 建立Network
```
docker network create practice
```

## 建立 Mysql Container

```
docker run --name practice_mysql --net practice -v //d/Shark/Practice/Docker/Volume/MySql:/var/lib/mysql -p 13306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql
```

## 建立 Web Image
此範例是用我寫的Springboot應用程式當範例
* 下載專案
```
git clone https://github.com/Shark0/DockerSpringBootExample.git
```
* 建置專案
```
mvn clean package -P docker
```
* 進入專案建置image
```
cd DockerSpringBootExample
docker build -t practice_springboot . --no-cache
```

## 建立 Web Container
```
docker run --name practice_springboot --net practice -p 18080:8080 -d practice_springboot
```

## 用Docker Compose建置專案
```
docker-compose up
```