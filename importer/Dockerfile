FROM java:8-jre

RUN wget http://xbib.org/repository/org/xbib/elasticsearch/importer/elasticsearch-jdbc/2.3.3.0/elasticsearch-jdbc-2.3.3.0-dist.zip

RUN unzip elasticsearch-jdbc-2.3.3.0-dist.zip

ENV JDBC_IMPORTER_HOME /elasticsearch-jdbc-2.3.3.0

WORKDIR elasticsearch-jdbc-2.3.3.0

COPY . .

RUN chmod +x run.sh

CMD ["./run.sh"]