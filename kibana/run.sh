#!/bin/bash
ES_HOST=${ES_HOST:-window.location.hostname}
ES_PORT=${ES_PORT:-9200}

sed -i "s/elasticsearch: \"http:\/\/\"+window.location.hostname+\":9200\",/elasticsearch: \"http:\/\/$ES_HOST:$ES_PORT\",/g"  /usr/share/nginx/www/config.js
nginx -c /etc/nginx/nginx.conf
