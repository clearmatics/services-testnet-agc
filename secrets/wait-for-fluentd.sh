#!/bin/sh

host=$1
shift
cmd=$@

recurse(){
    HEADERS=`curl -Is --connect-timeout 5 $host`
    CURLSTATUS=$?
    HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`

    if [ $CURLSTATUS -eq 28 ]
        then
            echo "fluentd not ready yet"
            sleep 4s
            recurse

    else
        # Check HTTP status code
        if [ $HTTPSTATUS -eq 200 ]
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

