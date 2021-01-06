#!/bin/sh

set -e

host="$1"
shift
cmd="$@"

recurse(){
    echo $host
    HEADERS=`curl -Is --connect-timeout ${1-5} $host`
    # HEADERS=`curl -Is --connect-timeout ${1-5} http://localhost:8888`
    HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`
    CURLSTATUS=$?

    if [ $CURLSTATUS -eq 28 ]
        then
            echo FALSE
            sleep 2s
            recurse

    else
        # Check HTTP status code
        if [ $HTTPSTATUS -le 399 ]
            then
                echo "Alright, fluentd is ready"
                echo "http status = $HTTPSTATUS"
                # echo $cmd
                exec $cmd
        else
            echo FALSE
            echo $HTTPSTATUS
            sleep 2s
            recurse
        fi
    fi
    } 

recurse
