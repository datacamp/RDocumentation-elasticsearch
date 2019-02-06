#!/bin/bash
set -e

dockerize -template /opt/embulk/packages.tmpl:/opt/embulk/packages.yml \
  -template /opt/embulk/versions.tmpl:/opt/embulk/versions.yml \
  -template /opt/embulk/topics.tmpl:/opt/embulk/topics.yml

embulk run /opt/embulk/"$@".yml