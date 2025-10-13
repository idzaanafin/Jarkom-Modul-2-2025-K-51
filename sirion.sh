auto eth0
iface eth0 inet static
    address 10.89.3.10
    netmask 255.255.255.0
    gateway 10.89.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

    ### No. 11
    apt-get update

apt-get install nginx -y

service nginx start

service nginx status

rm /etc/nginx/sites-available/default

rm /etc/nginx/sites-enabled/default

nano /etc/nginx/sites-available/reverse_proxy

```bash
# Reverse Proxy
upstream lindon_backend {
    server 10.89.3.4:80;   # IP Lindon (web statis)
}

upstream vingilot_backend {
    server 10.89.3.5:80;   # IP Vingilot (web dinamis)
}

server {
    listen 80;
    server_nama k51.com sirion.k51.com;

    access_log /var/log/nginx/sirion.access.log;
    error_log  /var/log/nginx/sirion.error.log;

    location = / {
        return 200 "Sirion Reverse Proxy aktif.\nGunakan /static atau /app untuk test.\n";
        add_header Content-Type text/plain;
    }

    location /static/ {
        proxy_pass http://lindon_backend/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /app/ {
        proxy_pass http://vingilot_backend/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

```

ln -s /etc/nginx/sites-available/reverse_proxy /etc/nginx/sites-enabled

curl http://www.k51.com/static/

curl http://www.k51.com/app/

