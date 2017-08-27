#!/bin/bash
echo "<------------------------------------------------->"
echo
echo "<------------------------------------------------->"
echo "cronjob running at "$(date)
export HOME="/root"

cd ~
. domains.conf

echo "domains are" $SUBDOMAINS

echo "deciding whether to renew the cert(s)"
if [ -f "/etc/nginx/keys/fullchain.pem" ]; then
  EXP=$(date -d "`openssl x509 -in /etc/nginx/keys/fullchain.pem -text -noout|grep "Not After"|cut -c 25-`" +%s)
  DATENOW=$(date -d "now" +%s)
  DAYS_EXP=$(( ( $EXP - $DATENOW ) / 86400 ))
  if [[ $DAYS_EXP -gt 30 ]]; then
    echo "Existing certificate is still valid for another $DAYS_EXP day(s); skipping renewal."
    exit 0
  else
    echo "Preparing to renew certificate that is older than 60 days"
  fi
else
  echo "Preparing to generate server certificate for the first time"
fi

echo "Temporarily stopping Nginx"
service nginx stop

echo "Generating/Renewing certificate"
/usr/local/letsencrypt-auto certonly -t --renew-by-default --standalone --standalone-supported-challenges tls-sni-01 --rsa-key-size 4096 --email $EMAIL --agree-tos $SUBDOMAINS2

echo "Restarting web server"
service nginx start
