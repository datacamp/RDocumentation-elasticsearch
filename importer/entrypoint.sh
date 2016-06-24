#!/bin/bash
set -e

dockerize \
  -template /opt/elasticsearch-jdbc/data/"$@":/tmpl/"$@" \
  -stdout /opt/elasticsearch-jdbc/logs/jdbc.log \
  -stdout /opt/elasticsearch-jdbc/data/statefile.json \
  java \
  -cp "/opt/elasticsearch-jdbc/lib/*" \
  -Dlog4j.configurationFile=/opt/elasticsearch-jdbc/bin/log4j2.xml \
  org.xbib.tools.Runner \
  org.xbib.tools.JDBCImporter \
  /tmpl/"$@"