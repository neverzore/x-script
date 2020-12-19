yum install -y rsync
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/i/inotify-tools-3.14-9.el7.x86_64.rpm
rpm -Uvh *rpm
yum install -y inotify-tools
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@ip

nohup /root/auto-sync.sh &> synclog &