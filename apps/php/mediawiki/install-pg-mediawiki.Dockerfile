FROM php:7.2-apache

RUN curl https://releases.wikimedia.org/mediawiki/1.40/mediawiki-1.40.1.tar.gz > mediawiki.tar.gz
RUN docker-php-ext-install pgsql

