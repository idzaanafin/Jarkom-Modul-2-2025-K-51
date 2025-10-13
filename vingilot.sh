auto eth0
iface eth0 inet static
    address 10.89.3.5
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 10
# rewrite NO 10 use nginx and php-fpm
apt update && apt install nginx -y
apt update && apt install php8.4-fpm -y

nano /var/www/html/index.php
# <?php
# echo "dinamis webserver";
# ?>

nano /var/www/html/about.php
# <?php
# echo "about page";
# ?>

# konfigurasi nginx agar tidak pakai .php di url
nano /etc/nginx/sites-available/default
# server {
#       listen 80 default_server;
#
#       root /var/www/html;
#       index index.php;
#       server_name app.k10.com;
#       rewrite ^/about$ /about.php last;
#       location / {
#               try_files $uri $uri/ /index.php?$query_string;
#       }
#       location ~ \.php$ {
#               include snippets/fastcgi-php.conf;
#               fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
#       }
# } 
service nginx restart