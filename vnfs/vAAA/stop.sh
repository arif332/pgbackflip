#! /bin/bash
sleep 2

date > /tngbench_share/stop_time.txt

#copy radius log file to check vaaa server issue
#cp /var/log/freeradius/radius.log /tngbench_share/radius.log
cp /var/log/freeradius/* /tngbench_share/

#collecting radius server status
echo "Message-Authenticator = 0x00, FreeRADIUS-Statistics-Type = all, Response-Packet-Type = Access-Accept" |radclient -x localhost:18121 status adminsecret>/tngbench_share/freeradius_stat.txt

#genreate result.yml
python ./log_intf_statistics.py /tngbench_share/result.yml
./radius_stat_processor.sh >>/tngbench_share/result.yml
