#! /bin/bash
sleep 2

date > /tngbench_share/stop_time.txt

#copy radius log file to check vaaa server issue
cp /var/log/freeradius/radius.log /tngbench_share/radius.log
