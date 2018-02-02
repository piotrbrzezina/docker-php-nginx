FROM php:7.1-fpm

ADD https://getcomposer.org/installer /usr/local/bin/composer-installer
ENV APCU_VERSION 5.1.8
RUN apt-get update && apt-get install --yes \
    cron \
    gettext \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxext-dev \
    libxml2-dev \
    libxrender-dev \
    nginx \
    zlib1g-dev \
    libfontconfig \
&& pecl install \
    redis \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install \
    bcmath \
    curl \
    gd\
    intl \
    json \
    mbstring \
    mcrypt \
    opcache \
    pdo \
    pdo_mysql \
    xml \
    zip \
    intl \
&& docker-php-ext-enable \
    redis \
&& pecl install \
    apcu-${APCU_VERSION} \
&& docker-php-ext-enable --ini-name 20-apcu.ini apcu \
&& docker-php-ext-enable --ini-name 05-opcache.ini opcache

COPY docker/app/php.ini /usr/local/etc/php/php.ini

RUN php /usr/local/bin/composer-installer --install-dir=/usr/local/bin --filename=composer \


# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --optimize-autoloader --classmap-authoritative \
	&& composer clear-cache

WORKDIR /srv/app


COPY ./docker/app/conf.d /etc/nginx/sites-enabled/
RUN service nginx stop


COPY docker/app/docker-entrypoint.sh /usr/local/bin/docker-app-entrypoint
RUN chmod +x /usr/local/bin/docker-app-entrypoint

ENTRYPOINT ["docker-app-entrypoint"]

EXPOSE 80
# Port 9000 is exposed by php:~fpm image
