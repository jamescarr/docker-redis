docker-redis
============

This is a [Docker](http://docker.io) project to bring up a local [Redis](http://redis.io) server.

Based on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker) : A minimal Ubuntu base image modified for Docker-friendliness.

## Running

### Clone repository and build Redis image

```bash
$ docker build -t redis github.com/beingenious/docker-redis.git
```

### Launch server

To simply run you can start it up as:
```bash
$ docker run -d -p 6379 redis
```

If you'd like to expose port 6379 to the world:
```bash
$ docker run -d -p 6379:6379 redis
```

You can optionnaly pass arguments to redis via command line:
```bash
$ docker run -d -p 6379 -e "ARGS=--maxmemory-policy allkeys-lru" redis
```

Or a redis configuration file:
```bash
$ docker run -d -p 6379 -v /tmp/redis:/tmp/redis -e "ARGS=/tmp/redis/redis.conf" redis
```
