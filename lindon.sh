auto eth0
iface eth0 inet static
    address 10.89.3.4
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 9
# rewrite use nginx
apt update && apt install nginx -y
mkdir /var/www/html/annals/
echo "halo dunia" > /var/www/html/annals/tes.txt
service nginx restart

