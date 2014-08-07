#!/bin/bash

# fail hard and fast even on pipelines
set -eo pipefail

# set debug based on envvar
[[ $DEBUG ]] && set -x

# configure etcd
export ETCD_PORT=${ETCD_PORT:-4001}
export ETCD="$HOST_IP:$ETCD_PORT"
export ETCD_PATH=${ETCD_PATH:-/redis}
export ETCD_TTL=${ETCD_TTL:-10}

while true; do
	PORT=`curl -s http://${HOST_IP}:2375/containers/${HOSTNAME}/json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["HostConfig"]["PortBindings"]["6379/tcp"][0]["HostPort"]'`
	etcdctl -C $ETCD set ${ETCD_PATH}/host ${HOST_IP} --ttl ${ETCD_TTL} > /dev/null
	etcdctl -C $ETCD set ${ETCD_PATH}/port ${PORT} --ttl ${ETCD_TTL} > /dev/null
	sleep $(($ETCD_TTL/2)) # sleep for half the TTL
done
