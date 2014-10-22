#!/bin/bash
set -e -x

export ETCD_PORT=${ETCD_PORT:-$ETCD_1_PORT_4001_TCP_PORT}
export ETCD_HOST=${ETCD_HOST:-$ETCD_1_PORT_4001_TCP_ADDR}
export ETCD=http://$ETCD_HOST:$ETCD_PORT

echo "[nginx] booting container. ETCD: $ETCD"

echo "starting supervisor in foreground"
supervisord -e debug
