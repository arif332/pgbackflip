#! /bin/bash

date > /tngbench_share/stop_time.txt

#genreate result.yml
python ./log_intf_statistics.py /tngbench_share/result.yml

vvv_server=20.0.0.254
apass=adminsecret
echo "Message-Authenticator = 0x00, FreeRADIUS-Statistics-Type = all, Response-Packet-Type = Access-Accept" |radclient -x $vvv_server:18121 status $apass >/tngbench_share/probe_freeradius_stat.txt

./radius_stat_processor.sh >>/tngbench_share/result.yml
