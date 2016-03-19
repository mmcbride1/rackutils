#!/bin/bash

# log file #
LOG=/var/log/hadoop-mg

# connection tries #
ATTEMPTS=0

# physical hosts #
NODES="192.168.1.239,192.168.1.241,192.168.1.235"

# write log file #
function log() {

   DATE=`date`
   echo "$DATE: $1" >> $LOG

}

# execute start command 
# five times total. if failed
# exit
while [ $ATTEMPTS -lt 5 ]
do

    sleep 5
  
    # exit code sum should be zero #
    PING=0
    
    node_lst=$(echo $NODES | tr "," "\n")

    for x in $node_lst
    do
        (ping -c 1 $x) > /dev/null 2>&1
        PING=$((PING+=$?))
    done

    if [ $PING -eq 0 ]
    then
        START=$(hadoop-mg start 2>&1 > /dev/null)
        if [ $? -eq 0 ]; then
            log 'cluster started successfully'
        else
            log "failure: $START"
        fi
        exit 1

    else
        ATTEMPTS=$((ATTEMPTS+=1))
        log 'connection failed. retrying...'
    fi

done

log 'conntection retires exhausted. aborting..'