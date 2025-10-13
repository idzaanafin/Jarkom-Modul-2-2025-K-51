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

apt update
apt install -y iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.89.0.0/16