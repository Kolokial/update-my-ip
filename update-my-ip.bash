#!/bin/bash

IPADDRESS=`curl checkip.amazonaws.com`
FILE=./current-ip-address

if test -f "$FILE"; then
    echo "$FILE exists."
    RECORDED_IP_ADDRESS=`cat $FILE`
    if [ "$RECORDED_IP_ADDRESS" = "$IPADDRESS" ]; then
        echo "they're the same!"
    else
    
    fi
else 
    touch $FILE
    echo $IPADDRESS > $FILE
fi



