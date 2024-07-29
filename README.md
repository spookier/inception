# Inception
## Project Overview
Inception is a System Administration project that focuses on using Docker to set up a small infrastructure composed of different services. The project involves creating and configuring Docker containers for various services, setting up volumes for data persistence, and establishing a docker network for inter-container communication  

All Docker images are built from scratch without using DockerHub

## Services

- NGINX: Acts as a reverse proxy and handles SSL/TLS termination
- WordPress: PHP-based content management system
- MariaDB: Database server for WordPress

## Features
- NGINX container with TLSv1.2 or TLSv1.3 only
- WordPress + php-fpm container
- MariaDB container
- Volume for WordPress database
- Volume for WordPress website files
- Docker network for container communication
- Automatic container restart on crash
- Domain name configuration (login.42.fr)
