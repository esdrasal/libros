# Libros

Una aplicación Ruby on Rails para gestionar libros y notas de lectura.

## Requisitos

* Ruby version: 3.3.1
* Rails version: ~> 8.0.2

## Configuración de base de datos

La aplicación está configurada para usar:
- MySQL en desarrollo local
- PostgreSQL en producción

## Instalación

1. Instalar dependencias:
   ```bash
   bundle install
   ```

2. Configurar la base de datos:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

3. Iniciar el servidor:
   ```bash
   rails server
   ```

## Funcionalidades

- Gestión de libros
- Sistema de notas de lectura
- Subida de imágenes con Cloudinary

## Ejecutar tests

```bash
rails test
```

## Despliegue

La aplicación está configurada para despliegue con Kamal.
