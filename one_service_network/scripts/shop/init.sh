#!/bin/sh

apk update
apk add bash iproute2 openssh nano python3

ip addr add 192.168.1.41/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.1.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

MY_USERNAME=shopowner

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

# Compile shop
echo "" > /etc/motd
gcc /scripts/shop.c -o /scripts/shop.out

# Wait for ssh to init
sleep 4

# Setup ssh key
ssh-keygen -A
mkdir -p /var/run/sshd
exec /usr/sbin/sshd -D&

mkdir -p /home/$MY_USERNAME/.ssh
touch /home/$MY_USERNAME/.ssh/authorized_keys
cat /shared/rsa.pub > /home/$MY_USERNAME/.ssh/authorized_keys
cp -v /shared/rsa.pub /home/$MY_USERNAME/.ssh/rsa.pub
rm /shared/*

# Start SSHD
ssh-keygen -A
mkdir -p /var/run/sshd
exec /usr/sbin/sshd -D&

# Setup terminal.shop
touch /etc/profile.d/shop.sh
echo "while true" >> /etc/profile
echo "do" >> /etc/profile
echo "python3 /scripts/shop.py" >> /etc/profile
echo "done" >> /etc/profile
