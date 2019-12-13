
#! /bin/bash
#sleep 2

#This probe will work as UAS (will wait for call from UAC)

imsconf=/ims-test-conf
own_ip_addr=20.0.0.1
local_port=3061
pcscf=20.0.0.254
remote_sip_port=4060

cd /tngbench_share

#sip registration command for alice from input probe
#sipp -sf non_em_reg_alice.xml 172.17.0.2:4060  -p 3061 -m 1
#sipp -sf /ims-test-conf/non_em_reg_alice.xml 172.17.0.2:4060  -p 3061 -m 1
#sipp -sf $imsconf/non_em_reg_alice.xml 20.0.0.254:4060  -p 3061 -m 1
#sipp -sf $imsconf/non_em_reg_alice.xml 20.0.0.254:4060 -i 20.0.0.1  -p 3061 -m 1
sipp -sf $imsconf/non_em_reg_alice.xml $pcscf:$remote_sip_port -i $own_ip_addr  -p $local_port -m 1


#alice wait for calls
sleep 3
#sipp -sf uas_b2a.xml 172.17.0.2:4060 -p 3061 -m 1
#sipp -sf /ims-test-conf/uas_b2a.xml 172.17.0.2:4060 -p 3061 -trace_stat
#sipp -sf $imsconf/uas_b2a.xml 20.0.0.254:4060 -p 3061 -m 1
#sipp -sf $imsconf/uas_b2a.xml 20.0.0.254:4060 -i 20.0.0.1 -p 3061 -m 1
sipp -sf $imsconf/uas_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -m 1
