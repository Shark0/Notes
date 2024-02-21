# Service 
## start
pg_ctl -D /usr/local/var/postgres start

## stop
pg_ctl -D /usr/local/var/postgres stop

# Sql
## add column
```
alter table ${table} add column ${column} ${column_type}
```

## delete column
```
alter table ${table} drop column ${column} ${column_type}
```