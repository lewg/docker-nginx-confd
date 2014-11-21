#!/bin/sh
ETCD_HOST=172.17.8.101:4002
etcdctl --peers $ETCD_HOST set /nginx/upstreams/app1/endpoints/server1 backend_1
etcdctl --peers $ETCD_HOST set /nginx/upstreams/app2/endpoints/server1 backend_1

etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/upstream app2

# etcdctl --peers $ETCD_HOST set /nginx/registry/hostname docker.local
# etcdctl --peers $ETCD_HOST set /nginx/registry/upstream app1

# etcdctl --peers $ETCD_HOST set /nginx/registry/users/test 'test:$apr1$NUgP1viV$xpr/B.wAZK70Vxh3nnWM3.'
