#! /bin/bash
date > /tngbench_share/start_time.txt
ip a s>/tngbench_share/system.log
ip r s>>/tngbench_share/system.log

/vaaa-test.sh >/tngbench_share/vaaa-test.log

#eval "$start_command"
