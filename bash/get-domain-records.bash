#!/bin/bash

source ./.credentials.bak

curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records?type=A"