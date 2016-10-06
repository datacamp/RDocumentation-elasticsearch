#!/bin/bash
set -e

dockerize \
  -template /opt/elasticsearch-jdbc/data/"$@":/tmpl/"$@" \
  java \
  -cp "/opt/elasticsearch-jdbc/lib/*" \
  -Dlog4j.configurationFile=/opt/elasticsearch-jdbc/bin/logging.xml \
  org.xbib.tools.Runner \
  org.xbib.tools.JDBCImporter \
  /tmpl/"$@"