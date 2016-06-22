#!/bin/bash


#download new data
now=`date +"%Y-%m-%d" --date "2012-10-01"`
end=`date +"%Y-%m-%d" --date "2012-05-23"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y-%m-%d" -d "$now + 1 day"`; 
        echo $now
done
#unzip

#transform


#index to es
#embulk run /path/to/config.yml -c /path/to/diff.yml