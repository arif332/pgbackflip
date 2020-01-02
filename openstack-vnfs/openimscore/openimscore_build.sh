#!/bin/bash

# Author: Arif Hossen (earihos@mail.uni-paderborn.de / arif332@gmail.com)
#
# OpenIMSCore Build Script for Ubuntu 18.04 LTS
# virt-customize is used to build customized image in offline
#
# V1 20191230 "Prepared Initial build script"
#
#


#cat /etc/hosts

#cd /usr/local/src

#grow image to max images size
df -h
lsblk
growpart /dev/sda 1
resize2fs /dev/sda1 
lsblk
df -h



#setup gcc soft link
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 1000

#install java and ant process
cd /opt
wget http://ftp.halifax.rwth-aachen.de/apache//ant/binaries/apache-ant-1.9.14-bin.tar.gz
tar zxf apache-ant-1.9.14-bin.tar.gz
export ANT_HOME="/opt/apache-ant-1.9.14"
export PATH=$PATH:$ANT_HOME/bin
export ANT_OPTS="-Dfile.encoding=utf-8"

#Install JDK 1.7
cd /opt
#COPY jdk-7u80-linux-x64.tar.gz /opt
#COPY bash_export.sh /opt
#RUN chmod +x bash_export.sh
tar zxf jdk-7u80-linux-x64.tar.gz
rm -f jdk-7u80-linux-x64.tar.gz
export JAVA_HOME=/opt/jdk1.7.0_80
update-alternatives --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 1500
update-alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 1500


#Copy ims source code and build
mkdir -p /opt/OpenIMSCore/FHoSS
mkdir -p /opt/OpenIMSCore/ser_ims
cd /opt/OpenIMSCore
svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS
svn checkout https://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
cd /opt/OpenIMSCore/FHoSS
mv build.xml build.xml.orig
cp /conf/build.xml build.xml
ant compile deploy

#compile ser package
cd /opt/OpenIMSCore/ser_ims
make install-libs all 


df -h
#import db configuration
cd /opt/OpenIMSCore
#service mysql start #&& mysql -u root < FHoSS/scripts/hss_db.sql && mysql -u root < FHoSS/scripts/userdata.sql && mysql -u root < ser_ims/cfg/icscf.sql
#systemctl start mysql
#systemctl start mariadb
service mysql start
mysql -u root < FHoSS/scripts/hss_db.sql
mysql -u root < FHoSS/scripts/userdata.sql
mysql -u root < ser_ims/cfg/icscf.sql

#copy config file
cp ser_ims/cfg/*.cfg . 	
cp ser_ims/cfg/*.xml .
cp ser_ims/cfg/*.sh .
cp /opt/OpenIMSCore/ser_ims/lib/*/*.so  /usr/local/lib/ser/
cp /conf/scscf.cfg scscf.cfg
cp /conf/icscf.cfg icscf.cfg
cp /conf/pcscf.cfg pcscf.cfg


#DNS server Setup
cd /etc/bind
cp /conf/open-ims.dnszone open-ims.dnszone
chown root:bind open-ims.dnszone

cp /conf/named.conf.default-zones named.conf.default-zones
chown root:bind named.conf.default-zones

cp /conf/named.conf.options named.conf.options
chown root:bind named.conf.options

cp /conf/resolv.conf.manual /etc/resolv.conf.manual


#configure nginx to access tomcat webserver for hoss 
#cp /conf/hss-reverseproxy.conf /etc/nginx/sites-available
#rm -f /etc/nginx/sites-enabled/default
#ln -s /etc/nginx/sites-available/hss-reverseproxy.conf /etc/nginx/sites-enabled/hss-reverseproxy.conf

cp /conf/entrypoint-openims.sh /opt/OpenIMSCore/entrypoint-openims.sh