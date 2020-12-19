su datadict -c "nohup java -javaagent:/home/apm/elastic-apm-agent-1.19.0.jar \
     -Delastic.apm.service_name=dict \
     -Delastic.apm.server_urls=http://ip:port \
     -Delastic.apm.global_labels=\"tags=['java','apm']\" \
     -jar database-dictionary-1.0-SNAPSHOT.jar &>logdata &"