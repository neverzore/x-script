cat >> /etc/security/limits.conf <<EOF
* soft nofile 128000
* hard nofile 128000
EOF