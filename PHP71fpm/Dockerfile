FROM php:7.1-fpm
MAINTAINER Humberto Barbosa <humberto.obarbosa@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y --force-yes libssl-dev curl  libcurl4-gnutls-dev libxml2-dev libicu-dev libmcrypt-dev  libmemcached11 libmemcached-dev

RUN apt-get install -y libmcrypt-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y libicu-dev
RUN apt-get install -y libbz2-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libxml2-dev libmemcached-dev zlib1g-dev
RUN pecl install memcached
RUN pecl install apcu
#LIBS
RUN docker-php-ext-install opcache
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install bz2
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install -j$(nproc) iconv mcrypt
RUN docker-php-ext-install intl
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install soap
RUN docker-php-ext-install zip
RUN docker-php-ext-enable memcached
RUN docker-php-ext-enable apcu

#GD
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

### INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  chmod +x /usr/local/bin/composer && \
  composer self-update

### CREATE USER FOR PRODUCTION
RUN useradd -u 1001 -G users,www-data -d /var/www --shell /bin/bash -m mdt && \
    echo "secret\nsecret" | passwd mdt

WORKDIR /var/www

EXPOSE 9000
CMD ["php-fpm"]
