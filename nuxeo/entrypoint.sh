#!/bin/bash
# Prevent key generation and password setup from being executed twice
if [ -f /root/keygeneration_done ]; then
    echo "$(cat /etc/issue)"
    exec "$@"
    exit 0
fi

# Regeneraet host keys
rm -f /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

# Set random password
nxpass=$(pwgen -c1)
chpasswd << EOF
root:$nxpass
nuxeo:$nxpass
EOF

cat << EOF >> /etc/issue
Default password for the root and nuxeo users: $nxpass
EOF

echo "$(cat /etc/issue)"
touch /root/keygeneration_done
chown -R nuxeo /var/log/nuxeo
chown -R postgres /var/log/postgresql
exec "$@"

