#
# Redis Dockerfile
#
#

# Pull base image.
FROM phusion/baseimage:0.9.9

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# Base system configuration
RUN apt-get update
RUN apt-get install -y build-essential wget

# Install redis
RUN cd /tmp && \
	wget http://download.redis.io/redis-stable.tar.gz && \
	tar -xzvf redis-stable.tar.gz && \
	cd redis-stable && make install

# Redis configuration files
ADD etc/redis/redis.conf /etc/redis/redis.conf

# Create Redis data directory
RUN mkdir -p /var/lib/redis /var/log/redis /var/run/redis

# Redis service
RUN mkdir /etc/service/redis
ADD bin/services/redis.sh /etc/service/redis/run

# open file limits
RUN echo "*               soft     nofile          65536" >> /etc/security/limits.conf && \
	echo "*               hard     nofile          65536" >> /etc/security/limits.conf

# Attach volumes.
VOLUME ["/var/lib/redis", "/var/log/redis"]

# Expose ports.
EXPOSE 6379

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Leverage the baseimage-docker init system
CMD ["/sbin/my_init", "--quiet"]