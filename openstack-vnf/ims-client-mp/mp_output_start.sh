#! /bin/bash


#This probe will work as UAC (will iniate call towards UAS)

date > /tngbench_share/start.txt

imsconf=/ims-test-conf
own_ip_addr=40.0.0.254
local_port=3062
pcscf=40.0.0.1
remote_sip_port=4060

cd /tngbench_share
#sleep 2
#sip registration command for bob from output probe
#sipp -sf non_em_reg_bob.xml 172.17.0.2:4060  -p 3062 -m 1
#sipp -sf /ims-test-conf/non_em_reg_bob.xml 172.17.0.2:4060  -p 3062 -m 1
#sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060  -p 3062 -m 1
#sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060 -i 40.0.0.254 -p 3062 -m 1
sipp -sf $imsconf/non_em_reg_bob.xml $pcscf:$remote_sip_port -i $own_ip_addr -p 3062 -m 1


sleep 7
#bob initiate call
#sipp -sf non_em_uac_b2a.xml 172.17.0.2:4060 -p 3062 -m 1
#sipp -sf /ims-test-conf/non_em_uac_b2a.xml 172.17.0.2:4060 -p 3062 -m 1 -trace_stat call_stat_uac.csv
#sipp -sf /ims-test-conf/non_em_uac_b2a.xml 172.17.0.2:4060 -p 3062 -trace_stat -rate_max 10 -rate_increase 5 -fd 1s
#sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -p 3062 -m 1
#sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -i 40.0.0.254 -p $local_port -m 1
#sipp -sf $imsconf/non_em_uac_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -m 1 -f 10 -trace_stat

#call load generator 
#sipp -sf $imsconf/non_em_uac_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -rate_increase 10 -rate_max 20 -m 50 -rp 5000 -l 100000 -f 10 -trace_stat -stat_delimiter ","

#sipp -sf $imsconf/non_em_uac_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -rate_increase 10 -rate_max 1000 -m 500 -rp 5000 -l 1000 -f 10 -trace_stat

sipp -sf $imsconf/non_em_uac_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -rate_increase 1000 -rate_max 100000 -m 5000000 -rp 5000 -l 5000000 -f 15 -trace_stat -fd 5
