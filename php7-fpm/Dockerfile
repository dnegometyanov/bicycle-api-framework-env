FROM php:7.1-fpm

MAINTAINER Denis Negometyanov <denis.negometyanov@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y  --force-yes software-properties-common

# Basic Requirements
RUN apt-get -y --force-yes install pwgen python-setuptools curl wget git unzip

RUN apt-get update && \
  apt-get install -y \
	  vim \
	  nano \
      mysql-client \
      libxml2-dev \
      openssl libssl-dev libcurl4-openssl-dev pkg-config libsasl2-dev libpcre3-dev

# Additional Requirements
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
  echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
  wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
        php7.0-common \
        php7.0-sqlite3 \
        php7.0-sqlite \
        php7.0-curl \
        php7.0-mbstring \
        php7.0-json \
        php7.0-xml \
    && rm -rf /var/lib/apt/lists/*

# Install MongoDB shell
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list && \
    apt-get update && \
    apt-get install -y --force-yes mongodb-org-shell && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php mongo extension
RUN pecl install mongodb && \
    echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini

RUN docker-php-ext-install mysqli opcache soap

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/bicycle-api-framework