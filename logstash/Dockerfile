FROM logstash:8.3.3

RUN logstash-plugin install logstash-filter-json_encode

RUN rm -f /usr/share/logstash/pipeline/logstash.conf

ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
ADD jdbc /usr/share/logstash/jdbc/
