FROM php:8.4-fpm-alpine3.22

# Install runtime dependencies
RUN apk add --no-cache \
    supervisor \
    git \
    zip \
    unzip \
    libpq-dev \
    libpng-dev \
    libzip-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    bash

# Install build dependencies, PHP extensions, then clean up
RUN apk add --no-cache --virtual .build-deps autoconf g++ make \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql bcmath gd zip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && rm -rf /tmp/pear

# Copy php.ini
COPY ${AG_MODULE_PATH}/php.ini /usr/local/etc/php/conf.d/php.ini

# Install Composer (from official image)
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Set working directory
WORKDIR /var/www/api

# Copy supervisor configs
COPY ${AG_MODULE_PATH}/supervisor/supervisord.conf /etc/supervisord.conf
COPY ${AG_MODULE_PATH}/supervisor/conf.d/ /etc/supervisor/conf.d/

# Run Supervisor (which manages php-fpm + workers)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf", "-n"]
