#!/bin/sh
ETCD_HOST=172.17.8.101:4002
# etcdctl --peers $ETCD_HOST set /nginx/upstreams/app1/endpoints/server1 backend_1
# etcdctl --peers $ETCD_HOST set /nginx/upstreams/app2/endpoints/server1 backend_1

# Clear old tests
etcdctl --peers $ETCD_HOST rm --dir --recursive /nginx
etcdctl --peers $ETCD_HOST rm --dir --recursive /services

# Fake registrator endpoints
etcdctl --peers $ETCD_HOST set /services/test_backend/123:test1:80 backend_1
etcdctl --peers $ETCD_HOST set /services/test_backend/234:test1:80 backend_1

etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/upstream test_backend

echo "TEST: curl http://docker.local"
read -p "Base setup in place upstreams added... " -n1 -s

etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/ssl_only on

echo "TEST: curl http://docker.local"
echo "TEST: curl -I http://docker.local"
echo "TEST: curl --insecure https://docker.local"
read -p "Forced that host to ssl_only ... " -n1 -s

etcdctl --peers $ETCD_HOST rm /nginx/hosts/docker.local/ssl_only
etcdctl --peers $ETCD_HOST set /nginx/users/test 'test:$apr1$NUgP1viV$xpr/B.wAZK70Vxh3nnWM3.'

read -p "Turned off SSL, Added a user (test/test)"

# Create passwords with: htpasswd -n [user]

etcdctl --peers $ETCD_HOST set /nginx/hosts/docker.local/secured on

echo "TEST: curl http://docker.local"
echo "TEST: curl --user test:test http://docker.local"
read -p "Forced docker.local to require auth" -n1 -p

etcdctl --peers $ETCD_HOST set /services/test2/123:test1:80 backend_1

read -p "Added a service with no host..." -n1 -p

etcdctl --peers $ETCD_HOST set /nginx/hosts/donotsee.local/upstream doesnotexist

read -p "Added a host with no upstream entries..." -n1 -p



etcdctl --peers $ETCD_HOST rm /services/test_backend/123:test1:80
etcdctl --peers $ETCD_HOST rm /services/test_backend/234:test1:80

read -p "Deleted services powering host..." -n1 -p
