# 1. Pakai Apache agar Web Server & PHP jadi satu paket
FROM php:8.4-apache

# 2. Install library pendukung Laravel & aktifkan mod_rewrite Apache
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip git unzip \
    && docker-php-ext-install pdo_mysql gd \
    && a2enmod rewrite

# 3. Arahkan Apache langsung ke folder /public Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 4. Ambil Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 5. Copy kodingan ke folder standar Apache di Linux (/var/www/html)
WORKDIR /var/www/html
COPY . /var/www/html

# 6. Install library Laravel
RUN composer install --no-dev --optimize-autoloader

# 7. Set izin akses folder agar tidak 500 Error
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80
