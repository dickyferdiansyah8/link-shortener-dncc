FROM php:8.4-fpm-alpine

# Install ekstensi yang dibutuhkan Laravel modern
RUN apk add --no-cache     libpng-dev     libzip-dev     zip     unzip     && docker-php-ext-install pdo pdo_mysql gd zip

WORKDIR /var/www
COPY  . /var/www

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader

# Izin akses folder
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
