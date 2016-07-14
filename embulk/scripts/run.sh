#!/bin/bash
trap "exit" INT
trap "exit" SIGINT

lastdate=$(cat /data/lastsync)
lastsync=`date +"%Y-%m-%d" --date "$lastdate"`
now=`date +"%Y-%m-%d" --date "today"`

echo "Syncing new stats...";

while [ "$lastsync" != "$now" ] ; 
do 
  #year
  year=`date +"%Y" -d "$lastsync"`; 
  #download new data
  wget_output=$(wget -O /data/zipped/$lastsync.csv.gz "http://cran-logs.rstudio.com/$year/$lastsync.csv.gz")
  if [ $? -ne 0 ]; then
    echo "Nothing new";
    rm /data/zipped/$lastsync.csv.gz
    exit;
  fi
  #unzip
  gzip -c -d /data/zipped/$lastsync.csv.gz > /data/unzipped/$lastsync.csv
  #transform
  /scripts/transform.sh /data/unzipped/$lastsync.csv > /data/transformed/$lastsync.csv
  #index
  embulk run /config/config.yml -c /config/diff.yml >> /logs/embulk.log
  #delete to not take disk space
  rm /data/zipped/$lastsync.csv.gz
  rm /data/unzipped/$lastsync.csv
  rm /data/transformed/$lastsync.csv
  lastsync=`date +"%Y-%m-%d" -d "$lastsync + 1 day"`; 
  #write progression
  echo "$lastsync" > /data/lastsync
done


echo "Done";
