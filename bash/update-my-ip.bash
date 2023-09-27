#!/bin/bash

source .credentials
IPADDRESS=`curl checkip.amazonaws.com`
FILE=./.current-ip-address

if test -f "$FILE"; then
    echo "$FILE exists."
    RECORDED_IP_ADDRESS=`cat $FILE`
    if [ "$RECORDED_IP_ADDRESS" = "$IPADDRESS" ]; then
        echo "they're the same!"
    else
        echo "they're not the same, will PATCH with $IPADDRESS"
        curl -X PATCH \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
            -d "{\"type\":\"A\", \"data\":\"$IPADDRESS\"}" \
            "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"

        echo $IPADDRESS > $FILE
    fi
else 
    touch $FILE
    curl -X PATCH \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
            -d "{\"type\":\"A\", \"data\":\"$IPADDRESS\"}" \
            "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"
    echo $IPADDRESS > $FILE
fi

