#!/bin/bash
groupadd elastic
useradd -g elastic -s /usr/sbin/nologin es

mkdir -p /home/es/config /home/es/data /home/es/plugin
chgrp -R elastic /home/es
chown -R es /home/es