#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd ~
git clone https://github.com/riyas-rawther/fix-dpkg.git
cd fix-dpkg
tar -xzf dpkg.tar.gz
mv dpkg /var/lib
rm /var/lib/dpkg/statoverride
rm -R * /var/lib/dpkg/info/

cp dpkg /usr/bin/
chmod 750 /usr/bin/dpkg

rm -r /var/lib/dpkg/info/* 
rm -r /etc/apt/sources.list.d/* 

sudo dpkg --configure -a
apt-get update
apt-get updgrade

echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse

deb http://archive.canonical.com/ubuntu focal partner
deb-src http://archive.canonical.com/ubuntu focal partner" > /etc/apt/sources.list.d/sources.list

sleep 1