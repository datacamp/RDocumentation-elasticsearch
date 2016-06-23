FROM java:8-jre

# Install base packages
RUN apt-get -y update \
 && apt-get install -y unzip wget gawk

# Install dockerize
RUN wget -O /tmp/dockerize-linux-amd64-v0.0.4.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.0.4/dockerize-linux-amd64-v0.0.4.tar.gz \
 && tar -C /usr/local/bin -xzvf /tmp/dockerize-linux-amd64-v0.0.4.tar.gz

# Install embulk
RUN wget http://dl.embulk.org/embulk-latest.jar -O /usr/local/bin/embulk && chmod +x /usr/local/bin/embulk

RUN embulk gem install embulk-output-elasticsearch

# Clean up APT when done.
RUN apt-get remove -y unzip \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME /config

VOLUME /data

VOLUME /scripts

VOLUME /logs

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]