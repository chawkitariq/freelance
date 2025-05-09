FROM composer:2.8.8 AS installer

COPY . .

RUN composer install --no-dev

FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    gettext \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    unzip \
    curl \
    mariadb-client \
    cron \
    --no-install-recommends && \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install -j$(nproc) \
    gd \
    opcache \
    mysqli \
    pdo_mysql \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY php.ini "$PHP_INI_DIR/php.ini"
COPY nginx.conf /etc/nginx/conf.d/default.conf.template

WORKDIR /var/www/app

COPY --from=installer /app .

EXPOSE 80
EXPOSE 443

CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]