#!/bin/sh

apk update
apk add bash iproute2 openssh sudo

ip addr add 192.168.1.24/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.1.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200


MY_USERNAME=shopcustomer

echo "configuring $MY_USERNAME"

echo "adding $MY_USERNAME"
adduser -D -H $MY_USERNAME
echo "$MY_USERNAME:$MY_USERNAME" | chpasswd

mkdir /home/$MY_USERNAME
chown root:$MY_USERNAME /home/$MY_USERNAME
chmod 750 /home/$MY_USERNAME

# Capture and display the directory permissions for /home/$MY_USERNAME
echo "Listed directory"
DIRECTORY_LIST=$(ls -ld /home/$MY_USERNAME)
echo "$DIRECTORY_LIST"

mkdir -p /home/shopcustomer/.ssh/
touch /home/shopcustomer/.ssh/known_hosts
chown -R shopcustomer:shopcustomer /home/shopcustomer/.ssh/
sudo -u shopcustomer ssh-keygen -t rsa -N "" -f /home/shopcustomer/.ssh/rsa
sed -i 's/shopcustomer@workstation1/shopcustomer@192.168.1.24/g' /home/shopcustomer/.ssh/rsa
cp -v /home/shopcustomer/.ssh/rsa.pub /shared/rsa.pub

# Set alias
echo "Host terminal.shop" > /home/shopcustomer/.ssh/config
echo "  Port 22" >> /home/shopcustomer/.ssh/config
echo "  User shopowner" >> /home/shopcustomer/.ssh/config
echo "  HostName 192.168.1.41" >> /home/shopcustomer/.ssh/config
echo "  IdentityFile /home/shopcustomer/.ssh/rsa" >> /home/shopcustomer/.ssh/config
echo "  IdentitiesOnly yes" >> /home/shopcustomer/.ssh/config
echo "  StrictHostKeyChecking no" >> /home/shopcustomer/.ssh/config
