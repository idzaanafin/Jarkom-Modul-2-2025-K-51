auto eth0
iface eth0 inet static
    address 10.89.1.2
    netmask 255.255.255.0
    gateway 10.89.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# NO 4
cat <<EOF > /etc/resolv.conf
nameserver 10.89.3.2
nameserver 10.89.3.3
nameserver 192.168.122.1
EOF