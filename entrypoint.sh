#!/bin/sh

if [ ! -f '/prox/xen/xenbus' ]; then
	mount -t xenfs xenfs /proc/xen
fi

exec "$@"
