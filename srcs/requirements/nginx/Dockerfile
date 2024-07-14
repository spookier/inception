FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

# generate the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"

# copy the nginx config
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# create wordpress directory
RUN mkdir -p /var/www/wordpress

# change the owner of the wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/wordpress

# run when the container starts
CMD ["nginx", "-g", "daemon off;"]
