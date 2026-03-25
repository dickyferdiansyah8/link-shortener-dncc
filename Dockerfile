FROM php:8.2-fpm

# 1. Install dependencies (opsional tapi disarankan)
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git unrar && docker-php-ext-install pdo_mysql gd

# 2. Tentukan direktori kerja
WORKDIR /var/www

# 3. SAKTI: Salin semua file project Laravel kamu ke dalam Image
COPY . /var/www

# 4. Beri izin akses (agar tidak error permission di Laravel)
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
