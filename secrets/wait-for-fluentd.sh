#!/bin/sh

host=$1
shift
cmd=$@

foo(){
    HEADERS=`curl -Is --connect-timeout 5 $host`
    CURLSTATUS=$?
    HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`

    # Check curl status
    while [ $CURLSTATUS -eq 28 ]
    do
        echo "fluentd not ready yet"
        sleep 4s
        HEADERS=`curl -Is --connect-timeout 5 $host`
        CURLSTATUS=$?
    done

    # check HTTP status is not empty
    while [ -z "$HTTPSTATUS" ]
    do
        echo "fluentd not ready yet"
        sleep 4s
        HEADERS=`curl -Is --connect-timeout 5 $host`
        HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`
    done

    # Check HTTP status code
    while [ $HTTPSTATUS -ne 200 ]
    do
        echo "fluentd not ready yet"
        sleep 4s
        HEADERS=`curl -Is --connect-timeout 5 $host`
        HTTPSTATUS=`echo $HEADERS | grep HTTP | cut -d' ' -f2`
    done


    echo "Alright, fluentd is ready"
    echo "http status = $HTTPSTATUS"
    # echo $cmd
    exec $cmd

    } 

foo
