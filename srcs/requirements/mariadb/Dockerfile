FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

# Copie of our config file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie of init script
COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

# Expose le port de la base de données
EXPOSE 3306

# start the script at the creation of container
ENTRYPOINT ["/usr/local/bin/init.sh"]