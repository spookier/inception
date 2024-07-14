FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

# copy install script from host to container
COPY ./tools/mdb-script.sh /mdb-script.sh

RUN chmod +x /mdb-script.sh

# runs when container start
ENTRYPOINT ["./mdb-script.sh"]
