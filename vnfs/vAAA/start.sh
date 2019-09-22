#!/bin/bash
date > /tngbench_share/start.txt

/etc/init.d/freeradius start >system.log
ip a s >>/tngbench_share/system.log
ip r s >>/tngbench_share/system.log
ps -ef >>/tngbench_share/system.log
#/etc/init.d/freeradius start>>/tngbench_share/system.log
radtest bob test 127.0.0.1 0 testing123>>/tngbench_share/system.log

#cp /var/log/freeradius/radius.log /tngbench_share/radius.log
#cp /var/log/ /tngbench_share/radius.log

