FROM elasticsearch:2.3

RUN ulimit -n 262144

COPY elasticsearch.yml /usr/share/elasticsearch/config
COPY logging.yml /usr/share/elasticsearch/config