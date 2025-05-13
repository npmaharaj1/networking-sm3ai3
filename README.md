# networking-sm3ai3

## Things I learnt overall
```
As per style guide:
    - Use snake case for yaml files
```

## Journal 1: Two node network
I created a network involving two workstations connected to a router, with one
connected to a switch
![](./two_node_networking/assets/topology.png)

For the router, I used the frrouting/frr image from dockerhub and teacher given
scripts for the switch setup. Small alpine containers provided a clean slate to 
build everything from the gorund up. The main problem faced was assigning static
IP Addresses to each of the workstations since I wanted to use as little shell
files as possible. To overcome this, I utilized shell arguments which looked
like the following:
```bash
IP=$1

ip addr add 192.168.1.$1/24 dev eth1
```
There was also a brief moment where machines could ping eachother even though
they weren't connected directly via endpoint connections. This was quickly
understood however though since machines were simply connected via their own 
docker network.

## Journal 2: One service network

