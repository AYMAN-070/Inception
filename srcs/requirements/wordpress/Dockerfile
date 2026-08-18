FROM debian:bookworm

RUN apt-get update -y && \
    apt-get install -y php7.4 php7.4-fpm php7.4-mysql wget tar bash mariadb-client

# dowload and install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Copie of our config file PHP
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copie OF INIT SCRIPT
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# creat folders for volumes
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Exposes port 9000 for communication with NGINX
EXPOSE 9000

# start script while creating container
ENTRYPOINT ["/usr/local/bin/init.sh"]