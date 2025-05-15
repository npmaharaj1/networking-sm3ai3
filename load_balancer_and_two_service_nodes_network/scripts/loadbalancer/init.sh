apk add haproxy rsyslog

ip addr add 192.168.1.$1/24 dev eth1
ip link set eth1 up

ip route del default via 172.20.20.1 dev eth0
ip route add default via 192.168.1.1 dev eth1 metric 100
ip route add default via 172.20.20.1 dev eth0 metric 200

touch /var/log/haproxy.log

echo "local0.* /var/log/haproxy.log" >> /etc/rsyslog.conf
echo "local1.* /var/log/haproxy_notice.log" >> /etc/rsyslog.conf 

haproxy -f /etc/haproxy/haproxy.cfg
