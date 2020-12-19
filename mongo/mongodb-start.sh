mkdir -p /home/mongodb/{keyfile,config,logs,db,run}

yum install -y numactl

cat >> /etc/systemd/system/mongod.service <<"EOF"
[Unit]
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network.target

[Service]
User=mongodb
Group=mongodb
Environment="OPTIONS=-f /home/mongodb/config/config.conf"
EnvironmentFile=-/etc/sysconfig/mongod
ExecStart=/usr/bin/numactl --interleave=all /usr/bin/mongod $OPTIONS
PermissionsStartOnly=true
Type=simple
# file size
LimitFSIZE=infinity
# cpu time
LimitCPU=infinity
# virtual memory size
LimitAS=infinity
# open files
LimitNOFILE=64000
# processes/threads
LimitNPROC=64000
# locked memory
LimitMEMLOCK=infinity
# total threads (user+kernel)
TasksMax=infinity
TasksAccounting=false
# Recommended limits for mongod as specified in
# https://docs.mongodb.com/manual/reference/ulimit/#recommended-ulimit-settings

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

sudo yum install -y mongodb-org-4.4.0 mongodb-org-server-4.4.0 mongodb-org-shell-4.4.0 mongodb-org-mongos-4.4.0 mongodb-org-tools-4.4.0

cat >> /etc/yum.conf <<"EOF"
exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools
EOF

# scp root@ip:/home/mongodb/node1/config-server/config/config.conf /home/mongodb/config/
# scp root@ip:/home/mongodb/node1/config-server/keyfile/keyfile /home/mongodb/keyfile/

# chown -R mongodb:mongodb /home/mongodb
# chmod -R 0740 /home/mongodb/config
# chmod -R 0775 /home/mongodb/db
# chmod -R 0700 /home/mongodb/keyfile
# chmod -R 0740 /home/mongodb/logs
# chmod -R 0755 /home/mongodb/run

