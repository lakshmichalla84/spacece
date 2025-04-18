# Use the official PHP + Apache base image
FROM php:8.1-apache

# Copy application code to Apache root directory
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Set ServerName to suppress Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable Apache modules
RUN a2enmod rewrite

# Start Apache in the foreground
CMD ["apache2-foreground"]
