#!/bin/bash
echo host = $NUXEO_PORT_5432_TCP_ADDR >> /etc/diamond/collectors/PostgresqlCollector.conf
exec "$@"
