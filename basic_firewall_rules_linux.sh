#!/bin/bash

#input rules

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
##white list
iptables -A INPUT -m iprange --src-range 10.x.1.1-10.x.1.255 -j ACCEPT
iptables -A INPUT -m iprange --src-range 172.16.x.1-172.16.x.21 -j ACCEPT

##
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp -j DROP

#output rules
iptables -A OUTPUT -m iprange --src-range 10.x.1.1-10.x.1.255 -j ACCEPT
iptables -A OUTPUT -m iprange --src-range 172.16.x.1-172.16.x.21 -j ACCEPT
iptables -A OUTPUT -p tcp -j DROP
#default policy

iptables --policy INPUT ACCEPT
iptables --policy OUTPUT ACCEPT 
