Host Interface Facts
====================
This module provides custom facts based on your machines interfaces. 

##Description
Custom Fact for the host interface on a machine. It finds the interface based on the gateway of netstat -rn. Works on FreeBSD, OSX, RedHat, Centos, Scientific, Ubuntu and probably others. I have found it extremely helpful building NSM servers and configure iptables. You can specify the variable <%= @hostint %> in your puppet templates.

Supports Interface, DNS, Duplex, Gateway, ipv4 address, ipv4 cidr, ipv4 max hosts, and Speed.
```
<%= @hostint %>           Host Interface - (Supports Kernel: FreeBSD, Darwin, Linux)
<%= @hostint_dns %>       Primary DNS Server (Supports Kernel: FreeBSD, Darwin, Linux) 
<%= @hostint_duplex %> 	  Full (Supports Kernel: Linux)
<%= @hostint_gw %>	  192.168.10.1 (Supports Kernel: FreeBSD, Darwin, Linux)
<%= @hostint_ipv4 %> 	  192.168.10.17 (Supports Kernel: FreeBSD, Darwin, Linux)
<%= @hostint_ipv4_cidr %> 192.168.10.0/24  (CIDR Notation: Should work on all *Nix)
<%= @hostint_ipv4_max %>  256 (Maximum number of hosts: Should work on all *Nix)
<%= @hostint_speed %> 	  1000Mb/s (Supports Kernel: Linux)
```

##Todo
Need to add Windows facts
