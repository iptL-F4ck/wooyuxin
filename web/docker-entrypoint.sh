#!/bin/bash
# setting up prerequisites

wait_for() {
    echo Waiting for $1 to listen on $2...
    while ! nc -z $1 $2; do echo waiting...; sleep 2; done
}

wait_for mongodb 27017
wait_for elasticsearch 9200

sleep 2

curl -XPUT "http://elasticsearch:9200/wooyun?pretty"
curl -XPOST "http://elasticsearch:9200/wooyun/wooyun_drops/_mapping?pretty" -H 'Content-Type:application/json' -d'
{
    "wooyun_drops": {
        "properties": {
            "html": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_smart"
            }
        }
    }
}'
curl -XPOST "http://elasticsearch:9200/wooyun/wooyun_list/_mapping?pretty" -H 'Content-Type:application/json' -d'
{
    "wooyun_list": {
        "properties": {
            "html": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_smart"
            }
        }
    }
}'

/usr/bin/supervisord -c /etc/supervisord.conf

pipenv run python /app/app.py