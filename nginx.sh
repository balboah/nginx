#!/bin/sh
if [ -n $UPSTREAM_PORT_8080_TCP_ADDR ]
then
	cat <<EOF > /etc/nginx/upstream.conf
upstream upstream {
	server $UPSTREAM_PORT_8080_TCP_ADDR:8080;
}
EOF
fi

nginx $@