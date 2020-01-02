#/bin/bash
#

# Author: Arif Hossen (earihos@mail.uni-paderborn.de / arif332@gmail.com)
#
# tng-bench-mp Build Script for Ubuntu 18.04 LTS
# virt-customize is used to build customized image in offline
#
# V1 20191230 "Prepared Initial build script"
#
#

image_in_web_1804=https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img
image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/cloud-image
image_name=tng-bench-mp_u18.04.img

cd /home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/tng-bench-mp

#http://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
# guestfish get-memsize
# run script --run test.sh
#--run SCRIPT


virt-customize -m 8192 -a $image_location/$image_name \
    --hostname "tng_bench_mp" \
    --run-command "dpkg --configure -a" \
    --run-command 'DEBIAN_FRONTEND=noninteractive' \
	--run-command 'apt-get update' \
	--run-command 'DEBIAN_FRONTEND=noninteractive' \
	--run-command 'apt-get install -y \
                           software-properties-common \
                           aptitude \
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
                           freeradius-utils' \
	--run-command 'mkdir -p /script' \
	--run-command 'mkdir -p /tngbench_share' \
	--run-command 'cd /' \
	--upload start.sh:/start.sh \
	--upload stop.sh:/stop.sh \
	--upload radius_stat_processor.sh:/radius_stat_processor.sh \
	--upload log_intf_statistics.py:/log_intf_statistics.py \
	--upload vaaa-bench.sh:/vaaa-bench.sh \
	--upload testuserdb:/testuserdb \
	--upload smalldb:/smalldb \
	--run-command 'cd /' \
	--run-command 'chmod +x radius_stat_processor.sh' \
	--run-command 'chmod +x log_intf_statistics.py' \
	--run-command 'chmod +x stop.sh' \
	--run-command 'chmod +x start.sh' \
	--run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' #\
	#--dry-run
