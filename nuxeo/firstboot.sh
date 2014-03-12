#!/bin/bash

# Prevent firstboot from being executed twice
if [ -f /root/firstboot_done ]; then
    su $NUXEO_USER -m -c "$NUXEOCTL --quiet restart"
    exit 0
fi

# PostgreSQL setup

#pgpass=$(pwgen -c1)
pgpass=nuxeo

su postgres -c "psql -p 5432 template1 --quiet -t -f-" << EOF > /dev/null
CREATE USER nuxeo WITH PASSWORD '$pgpass';
CREATE LANGUAGE plpgsql;
CREATE FUNCTION pg_catalog.text(integer) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int4out(\$1));';
CREATE CAST (integer AS text) WITH FUNCTION pg_catalog.text(integer) AS IMPLICIT;
COMMENT ON FUNCTION pg_catalog.text(integer) IS 'convert integer to text';
CREATE FUNCTION pg_catalog.text(bigint) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int8out(\$1));';
CREATE CAST (bigint AS text) WITH FUNCTION pg_catalog.text(bigint) AS IMPLICIT;
COMMENT ON FUNCTION pg_catalog.text(bigint) IS 'convert bigint to text';
EOF

su postgres -c "createdb -p 5432 -O nuxeo -E UTF-8 nuxeo"

# Nuxeo setup

cat << EOF >> /etc/nuxeo/nuxeo.conf
nuxeo.templates=postgresql
nuxeo.db.host=localhost
nuxeo.db.port=5432
nuxeo.db.name=nuxeo
nuxeo.db.user=nuxeo
nuxeo.db.password=$pgpass
EOF


su $NUXEO_USER -m -c "$NUXEOCTL --quiet restart"
# Prevent firstboot from being executed twice
touch /root/firstboot_done
