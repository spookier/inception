#!/bin/bash

service mariadb start # start mariadb
sleep 5 # wait for mariadb to start

#--------------config--------------#

# Create database if not exists
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

# Create user if not exists
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant privileges to user
#mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION ;"

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"


#--------------restart--------------#

# restart with new config
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# start mariadb in safe mode (if error = restart), listen on a specific port, listening to all connections, saving files @ path
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
