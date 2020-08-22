#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd ~
git clone https://github.com/riyas-rawther/fix-dpkg.git

mv /var/lib/dpkg/ ./dpkg.old
mv /usr/bin/dpkg ./dpkg.old

echo "Creating backups of your /var/lib/dpkg/ folder and /usr/bin/dpkg file to this folder"
sleep 2

cd fix-dpkg
tar -xzf dpkg.tar.gz
mv dpkg /var/lib
rm /var/lib/dpkg/statoverride
rm -R * /var/lib/dpkg/info/

cp dpkg /usr/bin/
chmod 750 /usr/bin/dpkg

rm -r /var/lib/dpkg/info/* 
rm -r /etc/apt/sources.list.d/* 

echo "deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse

deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse

deb http://archive.canonical.com/ubuntu focal partner
deb-src http://archive.canonical.com/ubuntu focal partner" > /etc/apt/sources.list

sudo dpkg --configure -a
apt-get update
apt-get upgrade

echo "Thank you for using the script."
sleep 1
echo "Rebooting."
reboot
