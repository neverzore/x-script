docker run --restart always -d --name es -p 9200:9200 -p 9300:9300 \
-v /home/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /home/es/data:/usr/share/elasticsearch/data \
-v /home/es/plugin:/usr/share/elasticsearch/plugins -v /home/es/logs:/usr/share/elasticsearch/logs \
-v /home/es/cert/elastic-certificates.p12:/usr/share/elasticsearch/config/certs/elastic-certificates.p12 \
--user 1000 \
--ulimit nofile=65535:65535 --ulimit nproc=65536:65536 --ulimit memlock=-1:-1 \
-e ES_JAVA_OPTS="-Xms16g -Xmx16g" \
-e "bootstrap.memory_lock=true" \
-e xpack.security.transport.ssl.keystore.password=passwd \
-e xpack.security.transport.ssl.truststore.password=passwd \
--log-opt max-size=64m \
docker.elastic.co/elasticsearch/elasticsearch:7.10.0