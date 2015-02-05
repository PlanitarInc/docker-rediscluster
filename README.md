# docker-rediscluster

Sets up a disposable redis cluster for testing sentinel failover.

## Cluster

#### Dependency

The cluster **requires** `etcd` available on `docker0` interface
(`172.17.42.1:4001`):

```sh
ocker run -d --name etcd --net host \
  -e SERVICE_IGNORE=true \
  planitar/etcd /etcd -addr 172.17.42.1:4001
```

#### Initial topology

redis_0 - master
redis_1 - slave of redis_0

sentinel_0
sentinel_1
sentinel_2

The sentinels are configured with a "redis-master" instance with the following properties -

```
down-after-milliseconds 1000
failover-timeout 1000
parallel-syncs 1
```

### Commands

- setup the cluster:

    ```sh
    ./cluster up
    ```

- remove the cluster:

    ```sh
    ./cluster down [-f]
    ```

  pass `-f` to remove any `redis.[0-9]+` and `sentinel.[0-9]+` docker
  containers.

- print status of the cluster:

    ```sh
    ./cluster status
    ```

- add redis node (the script makes the new node a slave of the current master):

    ```sh
    ./cluster add node
    ```

- add sentinel node (the script configures the new sentinel to monitor the
  current master):

    ```sh
    ./cluster add sentinel
    ```

- remove node/sentinel:

    ```sh
    ./node rem <node-id|node-name>
    ./sentinel rem <sentinel-id|sentinel-name>
    ```


## Node commands

- add a new node:

    ```sh
    ./node add <id|name> [<master-id|master-name>]
    ```

  `id|name` - the id (integer) or name (format `redis.<id>`of the new node).
  `master-id|master-name` set the new node a slave of given master (optional).

- remover a node:

    ```sh
    ./node rem <id|name>
    ```

- make a node slave of a given master:

    ```sh
    ./node slaveof <id|name> <master-id|master-name>
    ```

- open a redis-cli session on a node:

    ```sh
    ./node cli <id|name> [<command>]
    ```

if no command is specified, an interactive session is open
(the same behavior as of `redis-cli`).

- get the name of a node:

    ```sh
    ./node name <id|name>
    ```

- get an ip of a node:

    ```sh
    ./node ip <id|name>
    ```

- status of a node:

    ```sh
    ./node status <id|name>
    ```

## Sentinel commands

- add a new sentinel:

    ```sh
    ./sentinel add <id|name> [<master-id|master-name>]
    ```

  `id|name` - the id (integer) or name (format `sentinel.<id>`of the new sentinel).
  `master-id|master-name` monitor a given redis master (optional).

- remover a sentinel:

    ```sh
    ./sentinel rem <id|name>
    ```

- monitor a redis master node:

    ```sh
    ./sentinel monitor <id|name> <master-id|master-name>
    ```

- open a redis-cli session on a sentinel:

    ```sh
    ./sentinel cli <id|name> [<command>]
    ```

if no command is specified, an interactive session is open
(the same behavior as of `redis-cli`).

- get the name of a sentinel:

    ```sh
    ./sentinel name <id|name>
    ```

- status of a sentinel:

    ```sh
    ./sentinel status <id|name>
    ```
