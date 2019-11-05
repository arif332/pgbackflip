#! /bin/bash

date > /tngbench_share/start.txt

imsconf=/ims-test-conf

#sleep 2
#sip registration command for bob from output probe
#sipp -sf non_em_reg_bob.xml 172.17.0.2:4060  -p 3062 -m 1
#sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060  -p 3062 -m 1
sipp -sf $imsconf/non_em_reg_bob.xml 40.0.0.1:4060 -i 40.0.0.254 -p 3062 -m 1

sleep 4
#bob initiate call
#sipp -sf non_em_uac_b2a.xml 172.17.0.2:4060 -p 3062 -m 1
#sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -p 3062 -m 1
sipp -sf $imsconf/non_em_uac_b2a.xml 40.0.0.1:4060 -i 40.0.0.254 -p 3062 -m 1
