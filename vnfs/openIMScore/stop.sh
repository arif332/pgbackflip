#! /bin/bash
sleep 2


#stop process regarding openims core

python ./log_intf_statistics.py /tngbench_share/result.yml

date > /tngbench_share/stop_time.txt
