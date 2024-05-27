FROM php:8.1-cli-buster

RUN apt-get update && apt-get install -y \
    unzip \
    rsync \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libxslt-dev \
    libzip-dev \
    curl \
    build-essential \
    libxml2-dev \
    git-core \
    libsodium-dev \
    libmagickwand-dev --no-install-recommends \
    ssh

RUN pecl install imagick
RUN docker-php-ext-enable imagick
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && docker-php-ext-install gd

RUN docker-php-ext-install intl
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install sodium
RUN docker-php-ext-install sockets

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
