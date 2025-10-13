auto eth0
iface eth0 inet static
    address 10.89.3.2
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf


# NO 4 
apt update
apt install bind9 -y


nano /etc/bind/named.conf.local
# zone "k51.com" {
#     type master;
#     notify yes;
#     also-notify { 10.89.3.3; };
#     allow-transfer { 10.89.3.3; };
#     file "/etc/bind/k51.com";
# };

# zone "3.89.10.in-addr.arpa" {
# 	type master;
#     notify yes;
#     also-notify { 10.89.3.3; };
#     allow-transfer { 10.89.3.3; };
# 	file "/etc/bind/3.89.10.in-addr.arpa";
# };

nano /etc/bind/k51.com
# $TTL    604800          ; Waktu cache default (detik)
# @       IN      SOA     ns1.k51.com. root.k51.com. (
#                         2025100401 ; Serial (format YYYYMMDDXX)
#                         604800     ; Refresh (1 minggu)
#                         86400      ; Retry (1 hari)
#                         2419200    ; Expire (4 minggu)
#                         604800 )   ; Negative Cache TTL
# ;

# @       IN      NS      ns1.k51.com.
# @       IN      NS      ns2.k51.com.
# @       IN      A       10.89.3.10
# ns1     IN      A       10.89.3.2
# ns2     IN      A       10.89.3.3


nano /etc/bind/named.conf.options
# options {
#         directory "/var/cache/bind";

#         dnssec-validation no;

#         forwarders { 192.168.122.1; };
#         allow-query { any; };
#         auth-nxdomain no;
#         listen-on-v6 { any; };
# };

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart

# NO 5
nano /etc/bind/k51.com
# eonwe     IN      A       192.168.122.247
# earendil  IN      A       10.89.2.2
# elwing    IN      A       10.89.2.3
# cirdan   IN      A       10.89.1.2
# elrond    IN      A       10.89.1.3
# maglor    IN      A       10.89.1.4
# sirion   IN      A       10.89.3.10
# lindon   IN      A       10.89.3.4
# vingilot  IN      A       10.89.3.5

# NO 7
nano /etc/bind/k51.com
# www     IN      CNAME   sirion.k51.com.
# static IN      CNAME   lindon.k51.com.
# app   IN      CNAME   vingilot.k51.com.

# NO 8
nano /etc/bind/3.89.10.in-addr.arpa
# $TTL    604800          ; Waktu cache default (detik)
# @       IN      SOA     k51.com. root.k51.com. (
#                         2025100401 ; Serial (format YYYYMMDDXX)
#                         604800     ; Refresh (1 minggu)
#                         86400      ; Retry (1 hari)
#                         2419200    ; Expire (4 minggu)
#                         604800 )   ; Negative Cache TTL
# ;

# 3.89.10.in-addr.arpa.       IN      NS      k51.com.
# 10      IN      PTR     sirion.k51.com.
# 4       IN      PTR     lindon.k51.com.
# 5       IN      PTR     vingilot.k51.com.