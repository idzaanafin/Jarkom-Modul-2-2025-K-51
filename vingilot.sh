auto eth0
iface eth0 inet static
    address 10.89.3.5
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 10
apt update && apt install php8.4-fpm nginx -y

echo "<?php echo 'ini bedanda';  ?>" > /var/www/html/index.php
echo "<?php echo 'ini about';  ?>" > /var/www/html/about.php
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/


nano /etc/nginx/sites-available/k51.com
# server {
#     listen 80;
#     server_name app.k51.com;
#     root /var/www/html;
#     index index.php index.html;

#     location / {
#     try_files $uri $uri.php $uri/ /index.php?$query_string;

#     }

#     location ~ \.php$ {
# 	    include snippets/fastcgi-php.conf;
# 	    fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
# 	  }

#    location ~ ^/[^/]+$ {
#        if (-f $document_root$uri.php) {
#            rewrite ^(.*)$ $1.php last;
#        }
#    }

#     location ~ /\.ht {
#         deny all;
#     }
# }

ln -s /etc/nginx/sites-available/k51.com /etc/nginx/sites-enabled/
nginx -t
service nginx reload
service php8.4-fpm restart
service nginx restart