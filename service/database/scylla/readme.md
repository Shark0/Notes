# Scylla

## Create Container
```
docker exec -it scylladb nodetool status
```
check node
```
docker exec -it scylladb nodetool status
```

## Create Keyspace
```
CREATE KEYSPACE example
  WITH replication = {
    'class': 'NetworkTopologyStrategy',
    'replication_factor': 1
};
```

## Create Table
```
CREATE TABLE example.message (
  item_id bigint,
  user_id bigint,
  user_service varchar,
  time timestamp,
  PRIMARY KEY ((user_id, user_service), item_id)
);

CREATE INDEX time_index ON example.message(time);

CREATE MATERIALIZED VIEW message_view AS
    SELECT * FROM example.message
    
    PRIMARY KEY (item_id, time);
```

## Insert Value
```
INSERT INTO example.message (item_id, user_id, user_service, time) 
VALUES (4, 1, 'chit_chat', '2025-01-02 15:47:34.000');
```

## Query
```
select * from example.message
where user_id = 1 and user_service = 'chit_chat' and time <= '2025-01-03 15:47:34.000'
limit 20 allow filtering;
```
