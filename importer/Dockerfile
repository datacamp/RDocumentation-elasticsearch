FROM java:8-jre

# Install base packages
RUN apt-get -y update \
 && apt-get install -y unzip wget

# Install dockerize
RUN wget -O /tmp/dockerize-linux-amd64-v0.0.4.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.0.4/dockerize-linux-amd64-v0.0.4.tar.gz \
 && tar -C /usr/local/bin -xzvf /tmp/dockerize-linux-amd64-v0.0.4.tar.gz

# Install elasticsearch-jdbc
RUN wget -O /tmp/elasticsearch-jdbc-2.3.3.0.zip  http://xbib.org/repository/org/xbib/elasticsearch/importer/elasticsearch-jdbc/2.3.3.0/elasticsearch-jdbc-2.3.3.0-dist.zip \
 && unzip -d /opt /tmp/elasticsearch-jdbc-2.3.3.0.zip \
 && ln -s /opt/elasticsearch-jdbc-2.3.3.0 /opt/elasticsearch-jdbc

# Clean up APT when done.
RUN apt-get remove -y unzip wget \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/elasticsearch-jdbc

VOLUME /opt/elasticsearch-jdbc/data

VOLUME /opt/elasticsearch-jdbc/logs


CMD dockerize \
    -stdout logs/jdbc.log \
    -stdout data/statefile.json \
     java \
    -cp "/opt/elasticsearch-jdbc/lib/*" \
    -Dlog4j.configurationFile=/opt/elasticsearch-jdbc/bin/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter \
    data/package_version.json