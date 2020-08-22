# This will fix the following issues on Ubuntu 20.04 related to dpkg

## Run this script at your own risk.

1. dpkg-buildpackage: command not found
2. sudo: dpkg: command not found. 
3. Could not exec dpkg! E: Sub-process /usr/bin/dpkg returned an error code (100)

### Requirements:

* Linux - Ubuntu 20.04

### Usage:

```
sudo -i
cd ~
wget https://raw.githubusercontent.com/riyas-rawther/fix-dpkg/master/fix-dpkg.sh &&  chmod +x fix-dpkg.sh && bash fix-dpkg.sh

```


