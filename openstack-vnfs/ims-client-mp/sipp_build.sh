#!/bin/bash

cat /etc/hosts

cd /usr/local/src
ls
git clone -b 'v3.6.0' --single-branch https://github.com/SIPp/sipp.git
cd /usr/local/src/sipp
ls
git branch -a
./build.sh --with-pcap --with-sctp --with-openssl
cp sipp /usr/local/bin/

