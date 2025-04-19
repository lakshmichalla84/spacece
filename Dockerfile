FROM php:8.1-apache

# Install required dependencies and MySQL server
RUN apt-get update && apt-get install -y \
    default-mysql-server \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli \
    && apt-get clean

# Enable Apache modules
RUN a2enmod rewrite

# Set ServerName to suppress Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy application code to Apache root directory
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Add custom MySQL configuration if needed (optional)
# COPY my.cnf /etc/mysql/my.cnf

# Expose MySQL port if needed (optional)
EXPOSE 80 3306

# Start both MySQL and Apache using supervisord
RUN apt-get update && apt-get install -y supervisor

# Add supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Default command to run both MySQL and Apache
CMD ["/usr/bin/supervisord"]

