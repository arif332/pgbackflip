#! /bin/bash

date > /tngbench_share/start.txt

imsconf=/ims-test-conf
own_ip_addr=40.0.0.254
local_port=3062
pcscf=40.0.0.1
remote_sip_port=4060

#sleep 2
#sip registration command for bob from output probe
#sipp -sf non_em_reg_bob.xml 172.17.0.2:4060  -p 3062 -m 1
#sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060  -p 3062 -m 1
#sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060 -i 40.0.0.254 -p 3062 -m 1
sipp -sf $imsconf/non_em_reg_bob.xml $pcscf:$remote_sip_port -i $own_ip_addr -p 3062 -m 1


sleep 4
#bob initiate call
#sipp -sf non_em_uac_b2a.xml 172.17.0.2:4060 -p 3062 -m 1
#sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -p 3062 -m 1
#sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -i 40.0.0.254 -p $local_port -m 1
sipp -sf $imsconf/non_em_uac_b2a.xml $pcscf:$remote_sip_port -i $own_ip_addr -p $local_port -m 1
