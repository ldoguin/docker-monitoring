#!/bin/bash
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9300}

sed -i  "s/elasticsearch { host => docker }/elasticsearch { host => \"$ES_HOST\" port => $ES_PORT }/g" /opt/logstash/logstash.conf

/opt/logstash/bin/logstash -f /opt/logstash/logstash.conf  --verbose
