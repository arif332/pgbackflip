#!/bin/bash

# Author: Arif Hossen (earihos@mail.uni-paderborn.de / arif332@gmail.com)
#
# OpenIMSCore Build Script for Ubuntu 18.04 LTS
# virt-customize is used to build customized image in offline
#
# V1 20191230 "Prepared Initial build script"
# V2 20200102 "added disk resize option"
#
#

image_in_web_1804=https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img
image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/cloud-image
image_name=openimscore_u18.04.img

cd /home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/openimscore
#wget $image_in_web_1804

#http://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
# guestfish get-memsize
# run script --run test.sh
#--run SCRIPT
#--copy directory copy recursively
#--verbose 
#--dry-run

# Standard Ubuntu 18.04 LTS cloud image size is 2GB which is not sufficient for openimsocre, so follow below procedure to increase disk image size
#increase image disk size

image_size=`qemu-img info $image_location/$image_name|grep virtual|cut -d "(" -f2|cut -d " " -f1`
 
echo "Image size is $image_size" 

if [ $image_size -le 2500000000 ]; then       #2.5GB
	qemu-img info $image_location/$image_name
	qemu-img resize $image_location/$image_name +2G
	qemu-img info $image_location/$image_name
	virt-customize --memsize 1224  -a $image_location/$image_name \
		--hostname "openimscore" \
		--run-command 'DEBIAN_FRONTEND=noninteractive' \
		--run-command 'apt-get update' \
		--run-command 'apt-get install -y cloud-initramfs-growroot' \
		--run-command 'df -h' \
		--run-command 'lsblk' \
		--run-command 'growpart /dev/sda 1' \
		--run-command 'resize2fs /dev/sda1 ' \
		--run-command 'df -h' 
fi


#Install Necessary package realted to openimscore application
virt-customize --memsize 1224  -a $image_location/$image_name \
	--hostname "openimscore" \
	--run-command 'DEBIAN_FRONTEND=noninteractive' \
	--run-command 'apt-get update' \
	--run-command 'apt-get install -y \
                           bind9 \
                           bison \
                           build-essential \
                           curl \
                           flex \
                           gcc-4.8 \
                           g++-4.8 \
                           iproute2 \
                           ipsec-tools \
                           libcurl4-openssl-dev \
                           libmysqld-dev \
                           libxml2-dev \
                           mysql-server \
                           net-tools \
                           nginx \
                           python \
                           python3 \
                           python-dev \
                           python-yaml \
                           software-properties-common \
                           subversion \
                           tree \
                           git \
                           wget' \
	--run-command 'mkdir -p /script' \
	--run-command 'mkdir -p /tngbench_share' \
	--run-command 'mkdir -p /ims-test-conf'\
	--run-command 'mkdir -p /conf'\
	--run-command 'cd /' \
	--copy-in ims-test-conf:/ims-test-conf \
	--upload jdk-7u80-linux-x64.tar.gz:/opt/jdk-7u80-linux-x64.tar.gz \
	--upload bash_export.sh:/bash_export.sh \
	--upload build.xml:/opt/build.xml \
	--upload ser_ims_cfg/scscf.cfg:/conf/scscf.cfg \
	--upload ser_ims_cfg/icscf.cfg:/conf/icscf.cfg \
	--upload ser_ims_cfg/pcscf.cfg:/conf/pcscf.cfg \
	--upload conf/open-ims.dnszone:/conf/open-ims.dnszone \
	--upload conf/named.conf.default-zones:/conf/named.conf.default-zones \
	--upload conf/named.conf.options:/conf/named.conf.options \
	--upload conf/resolv.conf:/conf/resolv.conf.manual \
	--upload hss-reverseproxy.conf:/conf/hss-reverseproxy.conf \
	--upload entrypoint-openims.sh:/conf/entrypoint-openims.sh \
	--upload start.sh:/start.sh \
	--upload stop.sh:/stop.sh \
	--upload log_intf_statistics.py:/log_intf_statistics.py \
	--upload openimscore_build.sh:/openimscore_build.sh \
	--run-command 'cd /' \
	--run-command 'chmod +x openimscore_build.sh' \
	--run-command 'chmod +x start.sh' \
	--run-command 'chmod +x log_intf_statistics.py' \
	--run-command 'chmod +x stop.sh' \
	--run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' \
	--run "./openimscore_build.sh" 
	#--dry-run

	#--run "./openimscore_build.sh" \