#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd ~
#git clone https://github.com/riyas-rawther/fix-dpkg.git
wget https://github.com/riyas-rawther/fix-dpkg/archive/master.zip
unzip master.zip 
cd fix-dpkg-master


mv /var/lib/dpkg/ ./var-lib-dpkg.old
mv /usr/bin/dpkg ./usr-bin-dpkg.old

echo "Creating backups of your /var/lib/dpkg/ folder and /usr/bin/dpkg file to this folder"
sleep 2

mv dpkg /usr/bin/
chmod 750 /usr/bin/dpkg

tar -xzf dpkg.tar.gz
mv dpkg /var/lib
rm /var/lib/dpkg/statoverride
rm -R * /var/lib/dpkg/info/
mkdir -pv /var/lib/dpkg/info/
touch /var/lib/dpkg/info/format-new

 
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
#reboot
