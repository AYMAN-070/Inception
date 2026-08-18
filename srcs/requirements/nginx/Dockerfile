# Using the second to last stable version of Debian
FROM debian:bookworm

# update and installing  NGINX and OpenSSL (for security)
RUN apt-get update && apt-get install -y nginx openssl

# Creating the folder to store the security certificate
RUN mkdir -p /etc/nginx/ssl

# Generating the self-signed SSL certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ayhammou.42.fr/UID=ayhammou"

# creation folder for website
RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copying our custom configuration file to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# expose 443 port(HTTPS)
EXPOSE 443

# We launch NGINX in the foreground (daemon off) so that the container does not shut down
CMD ["nginx", "-g", "daemon off;"]