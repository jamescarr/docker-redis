#!/usr/bin/env bash

DEFAULT_CONFIG=/etc/redis/redis.conf

# pitrho/docker-precise-redis
if [[ -z "$ARGS" ]]; then
	ARGS=$DEFAULT_CONFIG
else
	if [[ "$ARGS" =~ ^--[a-z] ]]; then
		ARGS="$DEFAULT_CONFIG $ARGS"
	fi
fi

# system configuration for redis
sysctl vm.overcommit_memory=1 > /dev/null
sysctl -w fs.file-max=100000 > /dev/null

/usr/local/bin/redis-server $ARGS
