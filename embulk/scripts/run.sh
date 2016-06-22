#!/bin/bash


lastdate=$(cat /data/lastsync)
lastsync=`date +"%Y-%m-%d" --date "$lastdate"`
now=`date +"%Y-%m-%d" --date "yesterday"`

while [ "$lastsync" != "$now" ] ; 
do 
  lastsync=`date +"%Y-%m-%d" -d "$lastsync + 1 day"`; 
  #download new data
  wget -P /data/zipped/ "http://cran-logs.rstudio.com/2016/$lastsync.csv.gz"
  #unzip
  gzip -c -d /data/zipped/$lastsync.csv.gz > /data/unzipped/$lastsync.csv
  #transform
  /scripts/transform.sh /data/unzipped/$lastsync.csv > /data/transformed/$lastsync.csv
  echo $lastsync
done

#index to es
embulk run /config/config.yml -c /config/diff.yml
