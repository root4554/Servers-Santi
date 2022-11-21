#!/bin/bash

########################################################
# Script to install Wordpress on a Debian 8.2 server   #
#   ##           #       ##            ##  ########    #                
#   ##         #####     ## ##      ## ##  ##     ##   #             
#   ##        ##   ##    ##   ##  ##   ##  ########    #                     
#   ##       #########   ##     ##     ##  ##          #
#   ######  ##       ##  ##            ##  ##          #    

# Script para arrancar los conmandos de WP-CLI 

# Install LAMP-repp
sudo add-apt-repository ppa:ondrej/php

# Instalar la pila de LAMP 
sudo apt-get update
sudo apt-get install -y apache2 libapache2-mod-php mariadb-server php-mysql

# Comprobar el estado de apache2
#systemctl status apache2 mariadb -n 0

# Permetir  lsd conexiones de estandar al servicio web y las conexiones seguras
sudo ufw allow http
sudo ufw allow https

# Configurar LAMP en ubuntu
# Instalar phpmyadmin
#sudo nano /etc/php/8.1/apache2/php.ini
 
# Editar el timezone
sed -i 's@;date.timezone =@;date.timezone = Europe/Madrid@g' /etc/php/8.1/apache2/php.ini 
sed -i 's@error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT@error_reporting = E_ALL@g' /etc/php/8.1/apache2/php.ini
sed -i 's@display_errors = Off@display_errors = On@g' /etc/php/8.1/apache2/php.ini
sed -i 's@;display_startup_errors = Off@display_startup_errors = On@g' /etc/php/8.1/apache2/php.ini


# Recargar el servicio web
sudo systemctl reload apache2

# Instalalar MariaDB


# Probar la pila LAMP
# Crear un archivo de prueba
#sudo nano /var/www/html/info.php

# Añadir el siguiente código
echo "<?php phpinfo(); ?>" > /var/www/html/info.php


######################################################
#   ##            ##                  ########       #
#    ##          ##                   ##     ##      #
#     ##        ##                    ##     ##      #
#      ##  ##  ##                     ########       #      
#       ###  ###                      ##             #
#        ##  ##                       ##             #

# Instalar Wordpress
# Descargar el paquete de Wordpress
wget https://es.wordpress.org/latest-es_ES.tar.gz

# Descomprimir el paquete
sudo tar xf latest-es_ES.tar.gz -C /var/www/html/

# Cambiar el propietario de la carpeta
sudo chown -R www-data: /var/www/html/wordpress



#*******************************************#
# Base de datos de Wordpress
# Conectar a la base de datos
sudo mysql -u root -proot <<EOF
CREATE DATABASE wordpress charset utf8mb4 collate utf8mb4_unicode_ci;

CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '${1:-wordpress}';

GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';

exit
EOF

#*******************************************#
# Phpmyadmin
# Instalar phpmyadmin
sudo apt install -y php-{curl,gd,imagick,intl,mbstring,xml,zip}

# Recargar la configuración de apache
sudo systemctl reload apache2

# Servicio web
sudo a2enmod rewrite

# Crear un archivo de configuración
#sudo nano /etc/apache2/sites-available/wordpress.conf
# Añadir el siguiente código
echo "<Directory /var/www/html/wordpress/>
    AllowOverride All
    </Directory>" > /etc/apache2/sites-available/wordpress.conf


# Habilitar el sitio web
sudo a2ensite wordpress.conf


# Aplicar los cambios
sudo systemctl restart apache2
sudo systemctl reload apache2