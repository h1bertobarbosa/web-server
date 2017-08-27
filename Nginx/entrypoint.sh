#!/bin/bash

if [ ! -z $SUBDOMAINS ];
then
  echo "SUBDOMAINS entered, processing"
  for job in $(echo $SUBDOMAINS | tr "," " "); do
    export SUBDOMAINS2="$SUBDOMAINS2 -d "$job""
  done
  echo "Sub-domains processed are:" $SUBDOMAINS2
  echo -e "SUBDOMAINS2=\"$SUBDOMAINS2\" URL=\"$URL\"" > /root/domains.conf
else
  echo "No subdomains defined"
  echo -e "URL=\"$URL\"" > /root/domains.conf
fi

/usr/local/letsencrypt.sh

exec "$@"
