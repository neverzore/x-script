docker run -d --name es01 -p 19200:19200 -p 19300:19300 \
-v /home/es/config:/usr/share/elasticsearch/config -v /home/es/data:/usr/share/elasticsearch/data \
-v /home/es/plugin:/usr/share/elasticsearch/plugins -v /home/es/logs:/usr/share/elasticsearch/logs \
--user 1000 \
docker.elastic.co/elasticsearch/elasticsearch:7.7.0