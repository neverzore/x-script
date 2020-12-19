cat >> /etc/systemd/system/disable-transparent-huge-pages.service <<"EOF"
[Unit]
Description=Disable Transparent Huge Pages (THP)
DefaultDependencies=no
After=sysinit.target local-fs.target
Before=mongod.service

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo never | tee /sys/kernel/mm/transparent_hugepage/enabled > /dev/null'

[Install]
WantedBy=basic.target
EOF

systemctl daemon-reload
systemctl start disable-transparent-huge-pages
systemctl enable disable-transparent-huge-pages

cat /sys/kernel/mm/transparent_hugepage/enabled

mkdir -p /etc/tuned/virtual-guest-no-thp
cat >> /etc/tuned/virtual-guest-no-thp/tuned.conf <<"EOF"
[main]
include=virtual-guest

[vm]
transparent_hugepages=never
EOF
tuned-adm profile virtual-guest-no-thp