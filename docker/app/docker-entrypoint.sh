#!/bin/sh
set -e

chown -R www-data /srv/app/var

nginx

php-fpm


