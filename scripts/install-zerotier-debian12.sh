#!/bin/bash

https://download.zerotier.com/RELEASES/1.14.2/dist/debian/bookworm/zerotier-one_1.14.2_amd64.deb

dpkg -i zerotier-one_1.14.2_amd64.deb

systemctl start zerotier-one

systemctl enable zerotier-one 

#To connect a machine to a ZeroTier network
zerotier-cli join <networkID>

#Leaving a ZeroTier Network
#zerotier-cli leave <networkID>
rm -rf zerotier-one*

#ZeroTier CLI Commands
#zerotier-cli status
#systemctl status zerotier-one
#zerotier-cli listnetworks
exit 0
