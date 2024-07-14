FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat vim

# netcat? to ping the mariadb container to make sure it's running before wp container

# copy the wordpress init script to the root directory in the container
COPY ./tools/wp-script.sh /

RUN chmod +x wp-script.sh

ENTRYPOINT ["./wp-script.sh"]
