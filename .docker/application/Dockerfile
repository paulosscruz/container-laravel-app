FROM php:7.4.13-fpm-alpine3.12

WORKDIR /var/www

RUN apk add --no-cache \
  openssl \
  bash \
  unzip \
  vim \
  postgresql-dev \
  libpng-dev \
  libzip-dev \
  zlib-dev \
  icu-dev \
  git \
  $PHPIZE_DEPS

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN docker-php-ext-install pdo_pgsql \
    pgsql \
    zip \
    intl

RUN docker-php-ext-enable pdo_pgsql \
    pgsql \
    zip \
    intl

RUN docker-php-ext-install sockets

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN rm -rf /var/www/html \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
