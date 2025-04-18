# Use the official PHP + Apache base image
FROM php:8.1-apache

# Copy application code to Apache root directory
COPY . /var/www/html/

# Set permissions if needed
RUN chown -R www-data:www-data /var/www/html

# No EXPOSE directive here

# Optional: Enable Apache modules (like rewrite)
RUN a2enmod rewrite
