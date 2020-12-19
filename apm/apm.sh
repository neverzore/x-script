docker run -d \
  --restart always \
  --name=apm \
  --user=1000 \
  -m 6g \
  --log-opt max-size=64m \
  -p 8200:8200 \
  --add-host=elasticsearch:ip \
  --volume="/home/apm/config/apm-server.docker.yml:/usr/share/apm-server/apm-server.yml:ro" \
  --volume="/home/apm/logs:/usr/share/apm-server/logs" \
  docker.elastic.co/apm/apm-server:7.10.0 \
  --strict.perms=false