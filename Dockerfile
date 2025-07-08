# Imagen base para PHP con Apache
FROM php:8.1-apache

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm

# Instalar extensiones PHP necesarias
RUN docker-php-ext-install pdo_mysql mysqli mbstring exif pcntl bcmath gd zip

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configurar Apache
RUN a2enmod rewrite
COPY docker/apache-config.conf /etc/apache2/sites-available/000-default.conf

# Copiar archivos del proyecto
COPY . /var/www/html/

# Configurar variables de entorno
COPY includes/.env.example /var/www/html/includes/.env

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/public

# Instalar dependencias de Composer
RUN composer install --no-interaction --optimize-autoloader

# Instalar dependencias de Node.js y compilar assets
RUN npm install && \
    npx gulp dev

# Exponer puerto
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
