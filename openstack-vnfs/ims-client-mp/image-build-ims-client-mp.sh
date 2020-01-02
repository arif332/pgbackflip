#!/bin/bash

# Author: Arif Hossen (earihos@mail.uni-paderborn.de / arif332@gmail.com)
#
# ims-client-mp Build Script for Ubuntu 18.04 LTS
# virt-customize is used to build customized image in offline
#
# V1 20191230 "Prepared Initial build script"
#
#

image_in_web_1804=https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img
image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/cloud-image
image_name=ims-client-mp_u18.04.img

cd /home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/ims-client-mp

#wget $image_in_web_1804
#

#http://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
# guestfish get-memsize
# run script --run test.sh
#--run SCRIPT
#--copy directory copy recursively


virt-customize -m 8192 -a $image_location/$image_name \
    --hostname "ims_client_mp" \
	--run-command 'apt-get update' \
	--run-command 'DEBIAN_FRONTEND=noninteractive' \
	--run-command 'apt-get install -y \
	                       autoconf \
	                       automake \
	                       pkg-config \
	                       dh-autoreconf \
                           software-properties-common \
                           git \
                           wget \
                           build-essential \
                           net-tools \
                           iproute2 \
                           curl \
                           python \
                           python3 \
                           python-dev \
                           python-yaml \
                           ncurses-dev \
                           libgsl-dev \
                           libssl-dev \
                           libpcap-dev \
                           libncurses5-dev \
                           libsctp-dev \
                           lksctp-tools' \
	--run-command 'mkdir -p /script' \
	--run-command 'mkdir -p /tngbench_share' \
	--run-command 'mkdir -p /ims-test-conf'\
	--run-command 'cd /' \
	--copy-in ims-test-conf:/ims-test-conf \
	--upload mp_input_start.sh:/mp_input_start.sh\
	--upload mp_output_start.sh:/mp_output_start.sh\
	--upload python_stat_processor.py:/python_stat_processor.py\
	--upload stat_processor.sh:/stat_processor.sh\
	--upload ims-client-reg.sh:/ims-client-reg.sh \
	--upload stop.sh:/stop.sh \
	--upload log_intf_statistics.py:/log_intf_statistics.py \
	--upload sipp_build.sh:/sipp_build.sh \
	--run-command 'cd /' \
	--run-command 'chmod +x sipp_build.sh' \
	--run-command 'chmod +x mp_input_start.sh' \
	--run-command 'chmod +x mp_output_start.sh' \
	--run-command 'chmod +x python_stat_processor.py' \
	--run-command 'chmod +x stat_processor.sh' \
	--run-command 'chmod +x ims-client-reg.sh' \
	--run-command 'chmod +x log_intf_statistics.py' \
	--run-command 'chmod +x stop.sh' \
	--run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' \
	--run "./sipp_build.sh" #\
	#--dry-run

