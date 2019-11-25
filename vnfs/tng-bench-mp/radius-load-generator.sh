
echo "`data` : starting radclient for testing"
radclient  -c 1000 -n 1000 -p 1000 -s -q -f smalldb $vvv_server:1812 auth $rsecret
echo "`date` : starting radclient big testing"
radclient  -c 10000000 -n 1000000 -p 1000000 -s -q -f testuserdb $vvv_server:1812 auth $rsecret

echo "Message-Authenticator = 0x00, FreeRADIUS-Statistics-Type = all, Response-Packet-Type = Access-Accept" |radclient -x localhost:18121 status adminsecret


arif@tng-bench-vm:/usr/local/src/tng-bench-experiments/results$ grep -r "FreeRADIUS-Total-Access-Requests" */*/*/freeradius_stat.txt
vAAA1_00000/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 46034
vAAA1_00001/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 238357
vAAA1_00002/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 182044
vAAA1_00003/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 259663
vAAA1_00004/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 284076
vAAA1_00005/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 288525
vAAA1_00006/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 291201
vAAA1_00007/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 285329
vAAA1_00008/mn.vnf0.vdu01.0/tngbench_share/freeradius_stat.txt:	FreeRADIUS-Total-Access-Requests = 291766
arif@tng-bench-vm:/usr/local/src/tng-bench-experiments/results$ 



