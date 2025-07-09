# DevWebUCLA - Sistema de Gestión de Eventos

## Descripción General
DevWebUCLA es una aplicación web para la gestión integral de eventos académicos, diseñada para la Universidad Centroccidental Lisandro Alvarado (UCLA). El sistema facilita la administración de conferencias, talleres, ponentes y asistentes, ofreciendo una plataforma completa para la organización de eventos académicos.

## Características Principales

- Gestión completa de eventos, ponentes y asistentes
- Panel de administración intuitivo
- Sistema de registro y autenticación de usuarios
- Generación de boletos virtuales
- Sistema de regalos para asistentes
- API RESTful para integraciones
- Interfaz responsive y amigable

## Tecnologías Utilizadas

### Backend
- **PHP 8.1** - Lenguaje de programación del lado del servidor
- **MySQL 8.0** - Base de datos relacional
- **Apache** - Servidor web

### Frontend
- **JavaScript Vanilla** - Para interacciones dinámicas
- **HTML5/CSS3** - Estructura y estilos
- **Gulp** - Automatización de tareas
- **Webpack** - Empaquetado de módulos
- **Sass** - Preprocesador de CSS

### Infraestructura
- **Docker** - Contenedorización
- **Docker Compose** - Orquestación de servicios
- **Traefik** - Proxy inverso con HTTPS
- **Let's Encrypt** - Certificados SSL/TLS

## Estructura del Proyecto

```
devwebucla/
├── app/                # Controladores y lógica de negocio
├── includes/           # Configuración y utilidades
├── public/             # Punto de entrada público
│   ├── build/          # Assets compilados
│   └── index.php       # Front controller
├── templates/          # Vistas y plantillas
├── vendor/             # Dependencias de Composer
├── .env.example        # Ejemplo de variables de entorno
├── Dockerfile          # Configuración de Docker
└── docker-compose.yml  # Configuración de servicios
```

## Instalación

### Requisitos Previos
- Docker y Docker Compose instalados
- Git para clonar el repositorio

### Pasos de Instalación

1. Clonar el repositorio:
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd devwebucla
   ```

2. Copiar el archivo de variables de entorno:
   ```bash
   cp .env.example includes/.env
   ```

3. Configurar las variables de entorno en `includes/.env`

4. Construir y levantar los contenedores:
   ```bash
   docker-compose up -d --build
   ```

5. Instalar dependencias de Composer:
   ```bash
   docker-compose exec app composer install
   ```

6. Instalar dependencias de Node.js y compilar assets:
   ```bash
   docker-compose exec app npm install
   docker-compose exec app npx gulp build
   ```

7. Acceder a la aplicación en:
   - Frontend: `https://devwebucla.tudominio.com`
   - PHPMyAdmin: `http://localhost:8081` (si está configurado)

## Configuración

### Variables de Entorno
Asegúrate de configurar correctamente las siguientes variables en `includes/.env`:

```env
DB_HOST=db
DB_NAME=devwebucla
DB_USER=root
DB_PASS=tu_contraseña_segura
```

### Configuración de Correo
Actualiza la configuración de correo en el archivo de configuración correspondiente para habilitar notificaciones por correo electrónico.

## Licencia
Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más información.

## Contribuir
Las contribuciones son bienvenidas. Por favor, lee nuestras pautas de contribución antes de enviar un pull request.

## Soporte
Para soporte técnico, por favor abre un issue en el repositorio o contacta al equipo de desarrollo.

---

<div align="center">
  <p>Desarrollado con ❤️ por el equipo de DevWebUCLA</p>
  <p> 2025 DevWebUCLA - Todos los derechos reservados</p>
</div>