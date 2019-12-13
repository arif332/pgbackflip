#!/bin/bash

cd /tngbench_share

laststatfile=`ls -larth *ua*|tail -1|cut -d " " -f9`

cat $laststatfile | head -1 > /tngbench_share/temp_call_metrics.txt
cat $laststatfile | tail -1 >> /tngbench_share/temp_call_metrics.txt

python /python_stat_processor.py /tngbench_share/temp_call_metrics.txt /tngbench_share/final_metrics_for_openimscore.txt

cat /tngbench_share/final_metrics_for_openimscore.txt
