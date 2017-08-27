FROM nginx:1.13.3
MAINTAINER Humberto Barbosa <humberto.obarbosa@gmail.com>

RUN apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get update -y && apt-get install -y locales cron openssl build-essential wget

RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
RUN rm -Rf /etc/nginx/conf.d/
RUN mkdir -p /etc/letsencrypt
RUN wget https://raw.githubusercontent.com/certbot/certbot/master/certbot-auto && mv certbot-auto /usr/local/letsencrypt-auto
RUN chmod a+x /usr/local/letsencrypt-auto
RUN /usr/local/letsencrypt-auto -h

COPY ./entrypoint.sh        /usr/local/entrypoint.sh
COPY ./letsencryptcron.conf /usr/local/letsencryptcron.conf
COPY ./letsencrypt.sh       /usr/local/letsencrypt.sh

RUN chmod +x /usr/local/entrypoint.sh
RUN chmod +x /usr/local/letsencrypt.sh
RUN crontab  /usr/local/letsencryptcron.conf

RUN usermod -u 1000 www-data

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/entrypoint.sh"]
CMD ["nginx"]
