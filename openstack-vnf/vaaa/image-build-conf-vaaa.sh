#/bin/bash
#
cd /home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnf/vaaa

image_in_web=https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img

image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnf/cloud-image
image_name=xenial-vaaa.img

#http://manpages.ubuntu.com/manpages/xenial/man1/virt-customize.1.html
# guestfish get-memsize
# run script --run test.sh
#--run SCRIPT


virt-customize -m 8192 -a $image_location/$image_name \
   --hostname "vaaa" \
   --run-command 'apt-get update' \
   --run-command 'DEBIAN_FRONTEND=noninteractive' \
   --run-command 'apt-get install -y \
                          freeradius \
                          freeradius-utils \
                          python-yaml \
                          curl' \
   --run-command 'systemctl is-enabled freeradius.service' \
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
   --run-command 'echo "manage_etc_hosts: true" >> /etc/cloud/cloud.cfg' \
   --dry-run
