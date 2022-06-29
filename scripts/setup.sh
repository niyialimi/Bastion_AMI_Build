#!/bin/bash

sudo yum update -y

sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2

#---install the Apache web server and mariadb server
sudo yum install -y httpd mariadb-server

#---Start the Apache web server
sudo systemctl start httpd

#---Configure the Apache web server to start at each system boot
sudo systemctl enable httpd

sudo systemctl is-enabled httpd

#---Install php----#
sudo yum install php-mbstring -y

#----Restart Apache and php----#
sudo systemctl restart httpd
sudo systemctl restart php-fpm

cd /var/www/html

sudo wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz

sudo mkdir phpMyAdmin

sudo tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1

sudo rm phpMyAdmin-latest-all-languages.tar.gz

cd /var/www/html/phpMyAdmin

sudo mv config.sample.inc.php config.inc.php