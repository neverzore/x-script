cat >> /etc/security/limits.conf <<EOF
mongod soft nproc 4096
mongod hard nproc 16384
mongod soft nofile 2048
mongod hard nofile 65536
EOF