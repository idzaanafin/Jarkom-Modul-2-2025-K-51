auto eth0
iface eth0 inet static
    address 10.89.3.4
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 9
apt update && apt install nginx -y
mkdir /var/www/html/annals/
echo "halo dunia" > /var/www/html/annals/tes.txt

chown -R www-data:www-data /var/www/html/annals/
chmod -R 755 /var/www/html/annals


nano /etc/nginx/sites-available/k51.com
# server {
#     listen 80;
#     server_name static.k51.com;
#     root /var/www/html;

#     location / {
#         autoindex on;                 
#         autoindex_exact_size off;     
#         autoindex_localtime on;       
#     }
# }


ln -s /etc/nginx/sites-available/k51.com /etc/nginx/sites-enabled/
nginx -t
service nginx restart

