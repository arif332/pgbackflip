#! /bin/bash

date > /tngbench_share/stop_time.txt

#genreate result.yml
python ./log_intf_statistics.py /tngbench_share/result.yml

