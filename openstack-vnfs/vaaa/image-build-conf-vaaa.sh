#/bin/bash
#

# Author: Arif Hossen (earihos@mail.uni-paderborn.de / arif332@gmail.com)
#
# vaaa(freeradius) Build Script for Ubuntu 18.04 LTS
# virt-customize is used to build customized image in offline
#
# V1 20191202 "Prepared Initial build script"
# V2 20191230 "use ubuntu 18.04 lts"
#

image_in_web_1804=https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img
image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/cloud-image
image_name=vaaa_u18.04.img

cd /home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnfs/vaaa


#http://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
# guestfish get-memsize
# run script --run test.sh
#--run SCRIPT


virt-customize -m 8192 -a $image_location/$image_name \
   --hostname "vaaa" \
   --run-command 'DEBIAN_FRONTEND=noninteractive' \
   --run-command 'apt-get update' \
   --run-command 'apt-get install -y \
                          freeradius \
                          freeradius-utils \
                          python-yaml \
                          curl' \
   --run-command 'systemctl enable freeradius.service' \
   --run-command 'mkdir -p /script' \
   --run-command 'mkdir -p /tngbench_share' \
   --run-command 'cd /' \
   --upload raddb/clients.conf:/clients.conf \
   --upload raddb/mods-config/files/authorize:/authorize \
   --upload radius_stat_processor.sh:/radius_stat_processor.sh \
   --upload start.sh:/start.sh \
   --upload stop.sh:/stop.sh \
   --upload log_intf_statistics.py:/log_intf_statistics.py \
   --run-command 'cd /' \
   --run-command 'chmod +x radius_stat_processor.sh' \
   --run-command 'chmod +x log_intf_statistics.py' \
   --run-command 'chmod +x stop.sh' \
   --run-command 'chmod +x start.sh' \
   --run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' #\
   #--dry-run
