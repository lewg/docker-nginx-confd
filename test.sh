#!/bin/sh
ETCD_HOST=172.17.8.101:4002
etcdctl --peers $ETCD_HOST set /nginx/upstreams/app1/endpoints/server1 172.17.8.101:5030
etcdctl --peers $ETCD_HOST set /nginx/hosts/localhost/upstream app1
etcdctl --peers $ETCD_HOST set /nginx/registry/htpasswd 'lew:$apr1$p2Ba6ZhO$qlfF8vNpb2/e1aRtS4tVp1'
etcdctl --peers $ETCD_HOST set /nginx/registries/docker.local/upstream app1
# etcdctl --peers $ETCD_HOST set /nginx/registries/docker.local/cert_file appdev-wildcard-cert.pem
# etcdctl --peers $ETCD_HOST set /nginx/registries/docker.local/key_file appdev-wildcard-key.pem
