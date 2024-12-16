# Neo4j

## Install
### Docker
```
docker run --name neo4j_example -p7474:7474 -p7687:7687 -d neo4j:latest
docker exec -it neo4j_example cypher-shell -u neo4j -p neo4j
```

### Neo4j Desktop
[GUI工具](https://neo4j.com/download/)

## Example
### Create Node and Relation
```
CREATE (d:Database {name:"Neo4j"})-[r:SAYS]->(m:Message {name:"Hello World!"}) RETURN d, m, r
```

### Match
找Node
```
MATCH (d:Database {name:"Neo4j"}) Return d
```
找符合關係的Node
```
MATCH (d:Database {name:"Neo4j"})-[r:SAYS]->(m) Return d, m
```
```
MATCH (d:Database {name:"Neo4j"})-[*1..4]-(m)
RETURN DISTINCT m
```
找到最近關係
```
MATCH p=shortestPath(
(
d:Database {name:"Neo4j"})-[*]-(m:Message {name:"Hello World!")
)
RETURN p
```

### Delete
```
MATCH (n) DETACH DELETE n
```