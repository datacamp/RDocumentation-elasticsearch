#!/bin/bash
set -e

dockerize \
  -stdout /logs/embulk.log \
  -stdout /logs/bash.log \
  /scripts/run.sh > /logs/bash.logs