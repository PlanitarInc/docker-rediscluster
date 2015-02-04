#!/bin/sh

ETCD_URL=http://172.17.42.1:4001

MASTER="$1"
ROLE="$2"
STATE="$3"
FROM_IP="$4"
FROM_PORT="$5"
TO_IP="$6"
TO_PORT="$7"

# Log
# val="$(echo "M=$MASTER, R=$ROLE, S=$STATE, ${FROM_IP}:${FROM_PORT} -> ${TO_IP}:${TO_PORT}; [$@]")"
# curl $ETCD_URL/v2/keys/log/redis -XPOST -d value="$val"

curl $ETCD_URL/v2/keys/config/redis/master_ip -XPUT -d value="$TO_IP"
