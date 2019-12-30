#! /bin/bash
date > /tngbench_share/start_time.txt

sleep 5

echo "vaaa bench command started"
#radius authentication verification log
#/vaaa-test.sh >/tngbench_share/vaaa-user-verification.log
/vaaa-bench.sh >/tngbench_share/vaaa-bench-info.log

#eval "$start_command"
