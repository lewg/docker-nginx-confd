#!/bin/sh
ETCD_HOST=172.17.8.101:4002
etcdctl --peers $ETCD_HOST set /nginx/upstreams/app1/endpoints/server1 172.17.8.101:5030
etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/upstream app1
