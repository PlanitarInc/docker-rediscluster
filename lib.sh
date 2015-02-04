#!/bin/bassh

DOCKER_IP=172.17.42.1

log() {
  echo "[I] $@" >&2
}

d_ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$1"
}

d_rma() {
  local prefix="$1"
  docker rm -f $(docker ps -a | awk /${prefix}'\.[0-9]+ *$/ { print $1; }')
}

redis-cli() {
  docker run -ti --rm --net host planitar/redis redis-cli "$@"
}

get_name() {
  local prefix="$1"
  local id="$2"
  [[ "$id" == ${prefix}.* ]] && echo "$id" || echo "${prefix}.${id}"
}

etcdctl() {
  docker run -t --rm planitar/etcd /etcdctl "$@"
}
