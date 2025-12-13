# Imagen base para PHP con Apache
FROM php:8.1-apache

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    if command -v corepack >/dev/null 2>&1; then \
        corepack enable; \
        corepack prepare pnpm@9.15.0 --activate; \
    else \
        npm install -g pnpm@9.15.0; \
    fi

# Instalar extensiones PHP necesarias
RUN docker-php-ext-install pdo_mysql mysqli mbstring exif pcntl bcmath gd zip

# Instalar Composer
RUN set -eux; \
    EXPECTED_SIGNATURE="$(curl -fsSL https://composer.github.io/installer.sig)"; \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    ACTUAL_SIGNATURE="$(php -r 'echo hash_file("sha384", "composer-setup.php");')"; \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then \
        >&2 echo 'ERROR: Invalid composer installer signature'; \
        rm composer-setup.php; \
        exit 1; \
    fi; \
    php composer-setup.php --no-interaction --install-dir=/usr/local/bin --filename=composer; \
    rm composer-setup.php

# Configurar Apache
RUN a2enmod rewrite
COPY docker/apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
    && sed -i -E 's/(<VirtualHost[[:space:]]+\\*):80/\\1:8080/g' /etc/apache2/sites-available/000-default.conf

# Copiar archivos del proyecto
COPY . /var/www/html/

# Configurar variables de entorno
COPY .env /var/www/html/includes/.env

# Establecer permisos
RUN mkdir -p /var/run/apache2 /var/lock/apache2 /var/log/apache2 \
    && chown -R www-data:www-data /var/www /var/run/apache2 /var/lock/apache2 /var/log/apache2 \
    && chmod -R 755 /var/www/html/public \
    && chmod 640 /var/www/html/includes/.env

# Asegurar que .htaccess existe y tiene permisos correctos
RUN if [ -f /var/www/html/public/.htaccess ]; then \
        echo "El archivo .htaccess existe"; \
    else \
        echo "RewriteEngine On\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule ^ index.php [QSA,L]" > /var/www/html/public/.htaccess; \
    fi \
    && chmod 644 /var/www/html/public/.htaccess \
    && chown www-data:www-data /var/www/html/public/.htaccess

# Instalar dependencias de Composer
USER www-data
RUN composer install --no-interaction --optimize-autoloader

# Instalar dependencias de Node.js y compilar assets
RUN pnpm install --frozen-lockfile && \
    pnpm exec gulp build

# Exponer puerto
EXPOSE 8080

# Iniciar Apache
CMD ["apache2-foreground"]