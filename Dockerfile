   # Usa la imagen base de PHP con Apache
   FROM php:8.0-apache

   # Establece el directorio de trabajo
   WORKDIR /var/www/html

   # Copia el contenido del proyecto al contenedor
   COPY . /var/www/html/

   # Instala la extensión mysqli
   RUN docker-php-ext-install mysqli

   # Instala Composer
   RUN apt-get update && apt-get install -y git unzip \
       && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

   # Instala las dependencias de Composer
   RUN composer install