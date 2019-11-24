#! /bin/bash
date > /tngbench_share/start_time.txt

wait 2

#radius authentication verification log
/vaaa-test.sh >/tngbench_share/vaaa-user-verification.log

#eval "$start_command"
