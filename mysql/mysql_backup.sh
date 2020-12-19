#!/bin/bash
date=$(date +"%Y-%m-%d")
backup_dir="/data/mysql/backup"
backup_log="${backup_dir}/mysql_backup.log"
filename=$backup_dir/$date.sql
echo "开始备份: $(date +'%Y-%m-%d %H:%M:%S')" >> "$backup_log"
/usr/bin/mysqldump -S /var/run/mysqld/mysqld.sock --add-drop-table --single-transaction --all-databases > $filename
echo "备份成功： $filename" >> "$backup_log"
