FROM logstash:2.3

RUN curl -o /tmp/aws-env-linux-amd64 -L https://github.com/datacamp/aws-env/releases/download/v0.1-session-fix/aws-env-linux-amd64 && \
    chmod +x /tmp/aws-env-linux-amd64 && \
    mv /tmp/aws-env-linux-amd64 /bin/aws-env

RUN logstash-plugin install logstash-input-jdbc
RUN logstash-plugin install logstash-filter-json_encode

RUN rm -f /usr/share/logstash/pipeline/logstash.conf

ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
ADD jdbc /usr/share/logstash/jdbc/
