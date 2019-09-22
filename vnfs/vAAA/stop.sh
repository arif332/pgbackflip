#! /bin/bash
sleep 2

date > /tngbench_share/stop.txt
cp /var/log/freeradius/radius.log /tngbench_share/radius.log
