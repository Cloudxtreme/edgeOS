#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

## ----------------------------------------------------------------------------
## traffic-policy rules for ubiquiti edgeOS / edgeRouter / vyatta
## ...
## ----------------------------------------------------------------------------



## link download
set traffic-policy shaper 100-Download bandwidth auto
## ****************************************************************************

## link: garantia para openvpn
set traffic-policy shaper 100-Download class 10 bandwidth 80%

set traffic-policy shaper 100-Download class 10 burst 15k
set traffic-policy shaper 100-Download class 10 ceiling 100%
set traffic-policy shaper 100-Download class 10 description 'QOS OpenVPN'
set traffic-policy shaper 100-Download class 10 match icmp ip protocol icmp
set traffic-policy shaper 100-Download class 10 match openvpn1 ip destination port 1194
set traffic-policy shaper 100-Download class 10 match openvpn1 ip protocol udp
set traffic-policy shaper 100-Download class 10 match openvpn2 ip destination port 1294
set traffic-policy shaper 100-Download class 10 match openvpn2 ip protocol udp
set traffic-policy shaper 100-Download class 10 queue-type fair-queue
## ----------------------------------------------------------------------------

## link: garantia para ssh
set traffic-policy shaper 100-Download class 20 bandwidth 2%

set traffic-policy shaper 100-Download class 20 burst 15k
set traffic-policy shaper 100-Download class 20 ceiling 100%
set traffic-policy shaper 100-Download class 20 description SSH
set traffic-policy shaper 100-Download class 20 match ssh ip destination port 22
set traffic-policy shaper 100-Download class 20 match ssh ip dscp lowdelay
set traffic-policy shaper 100-Download class 20 match ssh ip protocol tcp
set traffic-policy shaper 100-Download class 20 queue-type fair-queue
## ----------------------------------------------------------------------------

## link1: garantia para dns
set traffic-policy shaper 100-Download class 30 bandwidth 2%

set traffic-policy shaper 100-Download class 30 burst 15k
set traffic-policy shaper 100-Download class 30 ceiling 100%
set traffic-policy shaper 100-Download class 30 description DNS
set traffic-policy shaper 100-Download class 30 match dns-t ip destination port 53
set traffic-policy shaper 100-Download class 30 match dns-t ip protocol tcp
set traffic-policy shaper 100-Download class 30 match dns-u ip destination port 53
set traffic-policy shaper 100-Download class 30 match dns-u ip protocol udp
set traffic-policy shaper 100-Download class 30 queue-type fair-queue
## ----------------------------------------------------------------------------

## link: garantia para servicos de email
set traffic-policy shaper 100-Download class 40 bandwidth 5%

set traffic-policy shaper 100-Download class 40 burst 15k
set traffic-policy shaper 100-Download class 40 ceiling 100%
set traffic-policy shaper 100-Download class 40 description Outros
set traffic-policy shaper 100-Download class 40 match imap ip destination port 143
set traffic-policy shaper 100-Download class 40 match imap ip protocol tcp
set traffic-policy shaper 100-Download class 40 match imap2 ip destination port 993
set traffic-policy shaper 100-Download class 40 match imap2 ip protocol tcp
set traffic-policy shaper 100-Download class 40 match pop3 ip destination port 110
set traffic-policy shaper 100-Download class 40 match pop3 ip protocol tcp
set traffic-policy shaper 100-Download class 40 match pop3s ip destination port 995
set traffic-policy shaper 100-Download class 40 match pop3s ip protocol tcp
set traffic-policy shaper 100-Download class 40 match smtp ip destination port 25
set traffic-policy shaper 100-Download class 40 match smtp ip protocol tcp
set traffic-policy shaper 100-Download class 40 match smtp2 ip destination port 587
set traffic-policy shaper 100-Download class 40 match smtp2 ip protocol tcp
set traffic-policy shaper 100-Download class 40 match smtps ip destination port 465
set traffic-policy shaper 100-Download class 40 match smtps ip protocol tcp
set traffic-policy shaper 100-Download class 40 queue-type fair-queue
## ----------------------------------------------------------------------------

## link: garantia para demais servicos (navegacao e outros servicos)
set traffic-policy shaper 100-Download default bandwidth 11%

set traffic-policy shaper 100-Download default burst 15k
set traffic-policy shaper 100-Download default ceiling 100%
set traffic-policy shaper 100-Download default queue-type fair-queue
## ----------------------------------------------------------------------------


## link: upload
set traffic-policy shaper 100-Upload bandwidth auto
## ****************************************************************************

## link: garantia para openvpn
set traffic-policy shaper 100-Upload class 10 bandwidth 80%

set traffic-policy shaper 100-Upload class 10 burst 15k
set traffic-policy shaper 100-Upload class 10 description VPN
set traffic-policy shaper 100-Upload class 10 match icmp ip protocol icmp
set traffic-policy shaper 100-Upload class 10 match openvpn ip destination port 1194
set traffic-policy shaper 100-Upload class 10 match openvpn ip protocol udp
set traffic-policy shaper 100-Upload class 10 match openvpn2 ip destination port 1294
set traffic-policy shaper 100-Upload class 10 match openvpn2 ip protocol udp
set traffic-policy shaper 100-Upload class 10 queue-type fair-queue
## ----------------------------------------------------------------------------

## link: garantia para servicos de email
set traffic-policy shaper 100-Upload class 20 bandwidth 5%

set traffic-policy shaper 100-Upload class 20 burst 15k
set traffic-policy shaper 100-Upload class 20 description Outros
set traffic-policy shaper 100-Upload class 20 match imap ip destination port 143
set traffic-policy shaper 100-Upload class 20 match imap ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match imap2 ip destination port 993
set traffic-policy shaper 100-Upload class 20 match imap2 ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match pop3 ip destination port 110
set traffic-policy shaper 100-Upload class 20 match pop3 ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match pop3s ip destination port 995
set traffic-policy shaper 100-Upload class 20 match pop3s ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match smtp ip destination port 25
set traffic-policy shaper 100-Upload class 20 match smtp ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match smtp2 ip destination port 587
set traffic-policy shaper 100-Upload class 20 match smtp2 ip protocol tcp
set traffic-policy shaper 100-Upload class 20 match smtps ip destination port 465
set traffic-policy shaper 100-Upload class 20 match smtps ip protocol tcp
set traffic-policy shaper 100-Upload class 20 queue-type fair-queue
## ----------------------------------------------------------------------------

## link: garantia para demais servicos
set traffic-policy shaper 100-Upload default bandwidth 15%

set traffic-policy shaper 100-Upload default burst 15k
set traffic-policy shaper 100-Upload default queue-type fair-queue
## ----------------------------------------------------------------------------


## aplicar esta regra na interface LAN
set interfaces ethernet eth0 traffic-policy out 100-Download
## aplicar esta regra nas interfaces WAN
set interfaces ethernet eth1 traffic-policy out 100-Upload
