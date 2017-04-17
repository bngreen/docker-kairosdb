docker-kairosdb
=======

## Docker Compose Example

docker-compose.yml: 

```yml
version: '2.1'
services:
  cassandra:
    image: "cassandra:latest"
    environment:
     -  CASSANDRA_START_RPC='true'
    expose:
     - "9160"
     - "9042"
  kairos:
    build: .
    ports:
     - "8083:8083"
     - "4242:4242"
    environment:
     - CASSANDRA_HOST_LIST=cassandra:9160
     - CASSANDRA_WAIT_HOST=cassandra:9160
    depends_on:
     - cassandra
```

Run: ```docker-compose up```

