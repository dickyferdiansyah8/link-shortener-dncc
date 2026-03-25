FROM php:8.4-fpm

# 1. Install dependencies sistem
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip git unzip \
    && docker-php-ext-install pdo_mysql gd

# 2. Ambil Composer dari image resmi
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# 3. Salin semua file project
COPY . /var/www

# 4. Jalankan install library (Tanpa dev agar ringan)
RUN composer install --no-dev --optimize-autoloader

# 5. Set permission
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
