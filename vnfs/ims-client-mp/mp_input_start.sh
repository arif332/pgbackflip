
#! /bin/bash
#sleep 2

#sip registration command for alice from input probe
#sipp -sf non_em_reg_alice.xml 172.17.0.2:4060  -p 3061 -m 1
sipp -sf non_em_reg_alice.xml 20.0.0.254:4060  -p 3061 -m 1

#alice wait for calls
sleep 2
#sipp -sf uas_b2a.xml 172.17.0.2:4060 -p 3061 -m 1
sipp -sf uas_b2a.xml 20.0.0.254:4060 -p 3061 -m 1
