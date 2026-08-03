#!/bin/bash

# Navigate to the website's folder
cd /var/www/html

# If wp-config.php does not exist, it means that WordPress is not yet installed
if [ ! -f "wp-config.php" ]; then
    echo "Installation de WordPress..."
    
    # dowloadWordPress
    wp core download --allow-root

    # creat config file linked to database
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --allow-root
    
    # install WordPress
    wp core install --url=$WP_URL --title="Mon Super Site Inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email="admin@42.fr" --allow-root
    
    # creat second standard user
    wp user create $WP_USER visiteur@42.fr --role=author --user_pass=$WP_USER_PASSWORD --allow-root

    echo "WordPress est installé avec succès !"
fi

# IMPORTANT : We create the directory so that PHP-FPM can start correctly.
mkdir -p /run/php

# On lance PHP-FPM au premier plan
exec php-fpm7.4 -F