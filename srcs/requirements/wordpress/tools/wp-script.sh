#!/bin/bash

# wp-cli INSTALL
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# go to wordpress directory
cd /var/www/wordpress

# Wait for MariaDB to be ready
while ! nc -z mariadb 3306; do   
  sleep 1
done

# WordPress INSTALL
wp core download --allow-root
wp core config --dbhost=mariadb --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
#create a new user
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root

# give permission to wordpress directory
chmod -R 755 /var/www/wordpress/
# change owner of wordpress directory to www-data
chown -R www-data:www-data /var/www/wordpress

# PHP CONFIG
# create a directory for php-fpm
mkdir -p /run/php

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# start php-fpm service in the foreground to keep the container running
/usr/sbin/php-fpm7.4 -F