export BACKUP_PATH=/home/nginx/conf/conf.d/
inotifywait --exclude '\.(part|swp|tmp)' -r -mq -e  modify,move_self,create,delete,move,close_write $BACKUP_PATH |
  while read event;
    do
    rsync -vazur --delete -e ssh $BACKUP_PATH root@ip:/home/nginx/conf/conf.d/
  done