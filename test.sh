#!/bin/sh
ETCD_HOST=172.17.8.101:4002
# etcdctl --peers $ETCD_HOST set /nginx/upstreams/app1/endpoints/server1 backend_1
# etcdctl --peers $ETCD_HOST set /nginx/upstreams/app2/endpoints/server1 backend_1

#

etcdctl --peers $ETCD_HOST set /services/test/123:test1:80 backend_1
etcdctl --peers $ETCD_HOST set /services/test/234:test1:80 backend_1

etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/upstream test

read -p "Base setup in place upstreams added... " -n1 -s

etcdctl --peers $ETCD_HOST set /services/test2/123:test1:80 backend_1

read -p "Added a service with no host..."

etcdctl --peers $ETCD_HOST set /nginx/hosts/donotsee.local/upstream doesnotexist

read -p "Added a host with no upstream entries..."

etcdctl --peers $ETCD_HOST rm /services/test/123:test1:80
etcdctl --peers $ETCD_HOST rm /services/test/234:test1:80

read -p "Deleted services powering host..."

# etcdctl --peers $ETCD_HOST set /nginx/registry/hostname docker.local
# etcdctl --peers $ETCD_HOST set /nginx/registry/upstream app1

# etcdctl --peers $ETCD_HOST set /nginx/registry/users/test 'test:$apr1$NUgP1viV$xpr/B.wAZK70Vxh3nnWM3.'
