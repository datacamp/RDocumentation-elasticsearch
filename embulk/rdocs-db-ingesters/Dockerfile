FROM dockerhub.datacamp.com:443/embulk-base

RUN mkdir -p /opt/embulk
COPY config/packages.yml /opt/embulk/packages.tmpl
COPY config/versions.yml /opt/embulk/versions.tmpl
COPY config/topics.yml /opt/embulk/topics.tmpl

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/embulk
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
