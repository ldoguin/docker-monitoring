#!/bin/bash -x

# Nuxeo setup

nuxeouid=$(grep nuxeo /etc/passwd | cut -d: -f3)
nuxeogid=$(grep nuxeo /etc/passwd | cut -d: -f4)

mkdir -p /var/lib/nuxeo

mkdir -p /tmp/nuxeo-distribution
unzip -q -d /tmp/nuxeo-distribution nuxeo-distribution.zip
distdir=$(/bin/ls /tmp/nuxeo-distribution | head -n 1)
mv /tmp/nuxeo-distribution/$distdir /var/lib/nuxeo/server
rm -rf /tmp/nuxeo-distribution
chmod +x /var/lib/nuxeo/server/bin/nuxeoctl
echo "org.nuxeo.distribution.packaging=vm" >> /var/lib/nuxeo/server/templates/common/config/distribution.properties

mkdir -p /etc/nuxeo
mv /var/lib/nuxeo/server/bin/nuxeo.conf /etc/nuxeo/nuxeo.conf

mkdir -p /var/log/nuxeo

chown -R $nuxeouid:$nuxeogid /var/lib/nuxeo
chown -R $nuxeouid:$nuxeogid /etc/nuxeo
chown -R $nuxeouid:$nuxeogid /var/log/nuxeo

cat << EOF >> /etc/nuxeo/nuxeo.conf
nuxeo.log.dir=/var/log/nuxeo
nuxeo.pid.dir=/var/run/nuxeo
nuxeo.data.dir=/var/lib/nuxeo/data
nuxeo.bind.address=127.0.0.1
nuxeo.server.http.port=8080
nuxeo.server.ajp.port=0
nuxeo.wizard.done=false
nuxeo.wizard.skippedpages=General,DB
metrics.graphite.enabled=true
metrics.graphite.host=docker
metrics.graphite.port=2030
metrics.graphite.period=10
metrics.log4j.enabled=true
metrics.log4j.period=10
metrics.tomcat.enabled=true
metrics.tomcat.period=10
EOF


# PostgreSQL setup

pg_dropcluster 9.3 main
LC_ALL=en_US.UTF-8 pg_createcluster --locale=en_US.UTF-8 --port=5432 9.3 nuxeodb
echo "kernel.shmmax = 301989888" >> /etc/sysctl.conf
pgconf="/etc/postgresql/9.3/nuxeodb/postgresql.conf"
perl -p -i -e "s/^#?shared_buffers\s*=.*$/shared_buffers = 100MB/" $pgconf
perl -p -i -e "s/^#?max_prepared_transactions\s*=.*$/max_prepared_transactions = 32/" $pgconf
perl -p -i -e "s/^#?effective_cache_size\s*=.*$/effective_cache_size = 1GB/" $pgconf
perl -p -i -e "s/^#?work_mem\s*=.*$/work_mem = 32MB/" $pgconf
perl -p -i -e "s/^#?wal_buffers\s*=.*$/wal_buffers = 8MB/" $pgconf
perl -p -i -e "s/^#?lc_messages\s*=.*$/lc_messages = 'en_US.UTF-8'/" $pgconf
perl -p -i -e "s/^#?lc_time\s*=.*$/lc_time = 'en_US.UTF-8'/" $pgconf
perl -p -i -e "s/^#?log_line_prefix\s*=.*$/log_line_prefix = '%t [%p]: [%l-1] '/" $pgconf
perl -p -i -e "s/^#?listen_addresses\s*=.*$/listen_addresses = '*'/" $pgconf
perl -p -i -e "s/^#?logging_collector\s*=.*$/logging_collector = on/" $pgconf
perl -p -i -e "s/^#?log_directory\s*=.*$/log_directory = '\/var\/log\/postgresql'/" $pgconf


mkdir -p /var/run/nuxeo
chown $NUXEO_USER:$NUXEO_USER /var/run/nuxeo


# Apache setup

a2enmod proxy proxy_http rewrite
a2dissite default
a2ensite nuxeo


