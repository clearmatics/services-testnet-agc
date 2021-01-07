#!/bin/sh

host=$1
shift
cmd=$@

recurse(){
    HEADERS=`curl -Is --connect-timeout ${1-5} $host`
    HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`
    CURLSTATUS=$?

    if [ $CURLSTATUS -eq 28 ]
        then
            echo "fluentd not ready yet"
            sleep 4s
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
            echo "fluentd not ready yet"
            sleep 4s
            recurse
        fi
    fi
    } 

recurse
