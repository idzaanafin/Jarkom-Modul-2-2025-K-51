auto eth0
iface eth0 inet static
    address 10.89.3.5
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 10
apt update && apt install php-fpm -y

nano /var/www/html/index.php
# <?php
# echo "dinamis webserver";
# ?>

nano /var/www/html/about.php
# <?php
# echo "about page";
# ?>

a2enmod rewrite

nano /var/www/html/.htaccess
# RewriteEngine On
# RewriteCond %{REQUEST_FILENAME} !-d
# RewriteRule ^([^\.]+)$ $1.php [NC,L]

nano /etc/apache2/sites-available/000-default.conf
# <Directory /var/www/html>
#     Options +FollowSymLinks -Multiviews
#     AllowOverride All
# </Directory>

service apache2 restart