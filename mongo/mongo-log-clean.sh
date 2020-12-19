find /home/mongodb/logs -mtime +90 -name "*.log.*" | xargs -i mv {} /root/recyclebin
find /root/recyclebin -mtime +30 -name "*.log.*" -exec rm -rf {} \
for i in `find /home/mongodb -name "*.log"`; do cat /dev/null >$i; done