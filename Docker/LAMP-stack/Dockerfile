FROM php:apache

# install PDO
RUN docker-php-ext-install pdo pdo_mysql

# rewrite the apache2.conf with AllowOveride All
COPY ./apache2.conf /etc/apache2/
RUN a2enmod rewrite
RUN service apache2 restart

