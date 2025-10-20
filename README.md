# praktikum-komdat-jarkom-k51

| Nama   | NRP |
|--------|------|
| Ahmad Idza Anafin   | 5027241017   |
| Erlangga Valdhio Putra Sulistio   | 5027241030   |

# MODUL 2

## TOPOLOGI JARINGAN
<img width="842" height="751" alt="image" src="https://github.com/user-attachments/assets/beaf8cd2-d217-4378-9943-78e920534f28" />

## KONFIGURASI JARINGAN
nomor 1-3 melakukan konfigurasi jaringan agar bisa saling terhubung satu sama lain dan terhubung di internet

### EONWE (Router)
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.89.2.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.89.1.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.89.3.1
    netmask 255.255.255.0
```

### Earendil (Klien Barat)
```
auto eth0
iface eth0 inet static
    address 10.89.2.2
    netmask 255.255.255.0
    gateway 10.89.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
### Elwing (Klien Barat)
```
auto eth0
iface eth0 inet static
    address 10.89.2.3
    netmask 255.255.255.0
    gateway 10.89.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
### Cirdan (Klien Timur)
```
auto eth0
iface eth0 inet static
    address 10.89.1.2
    netmask 255.255.255.0
    gateway 10.89.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
### Elrond (Klien Timur)
```
auto eth0
iface eth0 inet static
    address 10.89.1.3
    netmask 255.255.255.0
    gateway 10.89.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
### Maglor (Klien Timur)
```
auto eth0
iface eth0 inet static
    address 10.89.1.4
    netmask 255.255.255.0
    gateway 10.89.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Tirion (NS1)
```
auto eth0
iface eth0 inet static
    address 10.89.3.2
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Valmar (NS2)
```
auto eth0
iface eth0 inet static
    address 10.89.3.3
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Lindon (Web Server Statis)
```
auto eth0
iface eth0 inet static
    address 10.89.3.4
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Vingilot (Web Server Dinamis)
```
auto eth0
iface eth0 inet static
    address 10.89.3.5
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Sirion (Reverse Proxy)
```
auto eth0
iface eth0 inet static
    address 10.89.3.10
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf
```


Agar terhubung ke internet, konfigurasi rules iptables untuk routing ke luar
```
apt update
apt install -y iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.89.0.0/16
```

## KONFIGURASI DNS
Pada soal 4-8 diminta untuk melakukan konfigurasi DNS
### KONFIGURASI DNS MASTER (TIRION)
```
apt update
apt install bind9 -y


nano /etc/bind/named.conf.local
zone "k51.com" {
    type master;
    notify yes;
    also-notify { 10.89.3.3; };
    allow-transfer { 10.89.3.3; };
    file "/etc/bind/k51.com";
};

nano /etc/bind/k51.com
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     ns1.k51.com. root.k51.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

@       IN      NS      ns1.k51.com.
@       IN      NS      ns2.k51.com.
@       IN      A       10.89.3.10
ns1     IN      A       10.89.3.2
ns2     IN      A       10.89.3.3
eonwe     IN      A       192.168.122.247
earendil  IN      A       10.89.2.2
elwing    IN      A       10.89.2.3
cirdan   IN      A       10.89.1.2
elrond    IN      A       10.89.1.3
maglor    IN      A       10.89.1.4
sirion   IN      A       10.89.3.10
lindon   IN      A       10.89.3.4
vingilot  IN      A       10.89.3.5
www     IN      CNAME   sirion.k51.com.
static IN      CNAME   lindon.k51.com.
app   IN      CNAME   vingilot.k51.com.


nano /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        dnssec-validation no;

        forwarders { 192.168.122.1; };
        allow-query { any; };
        auth-nxdomain no;
        listen-on-v6 { any; };
};

nano /etc/bind/3.89.10.in-addr.arpa
$TTL    604800          ; Waktu cache default (detik)
@       IN      SOA     k51.com. root.k51.com. (
                        2025100401 ; Serial (format YYYYMMDDXX)
                        604800     ; Refresh (1 minggu)
                        86400      ; Retry (1 hari)
                        2419200    ; Expire (4 minggu)
                        604800 )   ; Negative Cache TTL
;

3.89.10.in-addr.arpa.       IN      NS      k51.com.
10      IN      PTR     sirion.k51.com.
4       IN      PTR     lindon.k51.com.
5       IN      PTR     vingilot.k51.com.

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```

### KONFIGURASI DNS SLAVE (Valmar)
```
nano /etc/bind/named.conf.local
zone "k51.com" {
    type slave;
    masters { 10.89.3.2; };
    file "/etc/bind/k51.com";
};

zone "3.89.10.in-addr.arpa" {
	type slave;
    masters { 10.89.3.2; };
	file "/etc/bind/3.89.10.in-addr.arpa";
};

ln -s /etc/init.d/named /etc/init.d/bind9
service bind9 restart
```

### PENGUJIAN DARI KLIEN
``` 
nano /etc/resolve.conf
nameserver 10.89.3.2
nameserver 10.89.3.1
nameserver 192.168.122.1
```
## KONFIGURASI WEBSERVER
### STATIS (Lindon)
```
apt update && apt install nginx -y
mkdir /var/www/html/annals/
echo "halo dunia" > /var/www/html/annals/tes.txt
service nginx restart
```

### DINAMIS (Vingilot)
```
apt update && apt install nginx -y
apt update && apt install php8.4-fpm -y

```

### PENGUJIAN DARI KLIEN
