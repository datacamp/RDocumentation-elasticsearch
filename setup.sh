#!/bin/bash

ES_URL="https://vpc-rdocumentation-t5xalaiufmoffmleu2so257pqm.us-east-1.es.amazonaws.com"

RDOC_INDEX="rdoc_v1"
RDOC_ALIAS="rdoc"

STATS_INDEX="stats_v1"
STATS_ALIAS="stats"

curl -XPUT ${ES_URL}/${RDOC_INDEX} -d "@mappings_rdoc.json"

curl -XPOST ${ES_URL}/_aliases -d "
{
    \"actions\" : [
        { \"add\" : { \"index\" : \"${RDOC_INDEX}\", \"alias\" : \"${RDOC_ALIAS}\" } }
    ]
}"

# curl -XPUT ${ES_URL}/${STATS_INDEX} -d "@mappings_stats.json"

# curl -XPOST ${ES_URL}/_aliases -d "
# {
#     \"actions\" : [
#         { \"add\" : { \"index\" : \"${STATS_INDEX}\", \"alias\" : \"${STATS_ALIAS}\" } }
#     ]
# }"

