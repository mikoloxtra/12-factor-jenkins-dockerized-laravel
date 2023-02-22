FROM php:8.2-fpm

ENV APP_ENV=production
ENV APP_DEBUG=false

WORKDIR /var/www/12factor

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
        nginx \
        git \
        zip \
        unzip \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        xml \
        zip

# Copy app files
COPY . /var/www/12factor/


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install app dependencies
RUN composer install --no-dev
#RUN chown -R 1000:www-data /var/www/12factor && chown -R 775 /var/www/12factor/storage/*

# Setup Nginx
RUN rm /etc/nginx/sites-enabled/default
COPY /nginx/app.conf /etc/nginx/conf.d/

COPY .env /var/www/12factor/.env
#RUN chown -R www-data:www-data /var/www/12factor

# Expose ports
EXPOSE 80

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm
