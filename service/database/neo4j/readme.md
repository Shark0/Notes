# Neo4j

## Install
### Docker
```
docker run --name example_neo4j -p7474:7474 -p7687:7687 -d neo4j:latest
docker exec -it example_neo4j cypher-shell -u neo4j -p neo4j
```

### Neo4j Desktop
[GUI工具](https://neo4j.com/download/)

### Neo4j Web
http://localhost:7474/browser/preview/

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
### Create Index
```
CREATE VECTOR INDEX sku_index IF NOT EXISTS
FOR (s:SKU)
ON s.embedding
OPTIONS { indexConfig: {
 `vector.dimensions`: 1,
 `vector.similarity_function`: 'cosine'
}}
```

### Query by index
```
MATCH (s:SKU {name: 'Apple iPhone 14 Pro 128GB'})
CALL db.index.vector.queryNodes('sku_index', 3, s.embedding)
YIELD node AS sku, score
RETURN sku.name AS name, score
```

### Sow Index
```
SHOW INDEXES
```

### Drop Index
```
DROP INDEX $index_name
```