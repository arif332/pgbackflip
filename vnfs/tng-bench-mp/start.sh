#! /bin/bash
date > /tngbench_share/start_time.txt
#ip a s>/tngbench_share/system.log
#ip r s>>/tngbench_share/system.log
#uptime>>/tngbench_share/system.log

#radius authentication verification log
/vaaa-test.sh >/tngbench_share/vaaa-user-verification.log

#eval "$start_command"
