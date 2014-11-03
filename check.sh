#!/bin/sh
ETCD_HOST=172.17.8.101:4002
etcdctl --peers $ETCD_HOST ls /nginx/upstreams
etcdctl --peers $ETCD_HOST ls /nginx/hosts
etcdctl --peers $ETCD_HOST ls /nginx/registry
etcdctl --peers $ETCD_HOST ls /nginx/registry/users
