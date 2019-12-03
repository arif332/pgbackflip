#/bin/bash
#



image_location=/home/arif/gitRepos/ah-tng-bench-experiments/openstack-vnf/cloud-image
image_name=xenial-server-cloudimg-amd64-disk1.img

virt-customize -a $image_location/$image_name \
--run-command 'apt-get install -y freeradius freeradius-utils python-yaml curl' \
--run-command 'systemctl is-enabled freeradius.service' \
--run-command 'systemctl enable freeradius.service' \
--mkdir /script \
--upload raddb/clients.conf:/script/clients.conf \
--upload raddb/mods-config/files/authorize:/script/authorize \
--upload start.sh:/script/start.sh \
--upload stop.sh:/script/stop.sh \
--upload radius_stat_processor.sh:/script/radius_stat_processor.sh \
--upload log_intf_statistics.py:/script/log_intf_statistics.py \
--run-command 'chmod +x /script/radius_stat_processor.sh' \
--run-command 'chmod +x /script/log_intf_statistics.py' \
--run-command 'chmod +x /script/stop.sh' \
--run-command 'chmod +x /script/start.sh' \
--mkdir /tngbench_share
