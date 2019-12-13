#! /bin/bash
sleep 2


#stop process regarding openims core

python ./log_intf_statistics.py /tngbench_share/result.yml
cat /dev/null>/tngbench_share/cmd_start.txt
echo "log clean completed" >/tngbench_share/cmd_start.log

date > /tngbench_share/stop_time.txt
