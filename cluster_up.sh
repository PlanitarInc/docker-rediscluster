#!/bin/bash

# create two redis instances
#  - redis.0 is master
#  - redis.1 is slave of redis.0
./node add redis.0
./node add redis.1 redis.0

# start up the sentinels
#  - sentinel.0 monitors redis.0
#  - sentinel.1 monitors redis.0
#  - sentinel.2 monitors redis.0
./sentinel add sentinel.0 redis.0
./sentinel add sentinel.1 redis.0
./sentinel add sentinel.2 redis.0
