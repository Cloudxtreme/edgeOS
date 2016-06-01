#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
source ./vars

set firewall group network-group rfc1918 network 192.168.0.0/16
set firewall group network-group rfc1918 network 172.16.0.0/12
set firewall group network-group rfc1918 network 10.0.0.0/8

set firewall group port-group allowed-ports port 22

set firewall name WAN_IN default-action drop
set firewall name WAN_IN description "WAN to LAN"
set firewall name WAN_IN rule 10 action accept
set firewall name WAN_IN rule 10 description "allow established/related"
set firewall name WAN_IN rule 10 state established enable
set firewall name WAN_IN rule 10 state related enable

## se estiver usando balanceamento de carga com mais de um link estas regras
## podem causar problemas
set firewall name WAN_IN rule 20 action drop
set firewall name WAN_IN rule 20 description "deny invalid state"
set firewall name WAN_IN rule 20 state invalid enable

set firewall name WAN_LOCAL default-action drop
set firewall name WAN_LOCAL description "WAN to router"
set firewall name WAN_LOCAL rule 10 action accept
set firewall name WAN_LOCAL rule 10 description "allow established/related"
set firewall name WAN_LOCAL rule 10 state established enable
set firewall name WAN_LOCAL rule 10 state related enable
set firewall name WAN_LOCAL rule 20 action drop
set firewall name WAN_LOCAL rule 20 description "deny invalid state"
set firewall name WAN_LOCAL rule 20 state invalid enable
set firewall name WAN_LOCAL rule 30 action accept
set firewall name WAN_LOCAL rule 30 destination group port-group allowed-ports
