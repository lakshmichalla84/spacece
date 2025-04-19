FROM php:8.1-apache

# Update apt and install necessary dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libmariadb-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli && docker-php-ext-enable mysqli

# Enable Apache modules
RUN a2enmod rewrite

# Set ServerName to suppress Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy application code to Apache root directory
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Start Apache in the foreground
CMD ["apache2-foreground"]
