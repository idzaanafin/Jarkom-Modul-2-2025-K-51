auto eth0
iface eth0 inet static
    address 10.89.3.3
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 4
apt update
apt install bind9 -y

nano /etc/bind/named.conf.local
# zone "k51.com" {
#     type slave;
#     masters { 10.89.3.2; };
#     file "/etc/bind/k51.com";
# };


ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart

# NO 8
nano /etc/bind/named.conf.local
# zone "3.89.10.in-addr.arpa" {
# 	type slave;
# 	file "/etc/bind/3.89.10.in-addr.arpa";
# };


