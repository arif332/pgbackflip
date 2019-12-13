#!/bin/bash

cd /tngbench_share

laststatfile=`ls -larth *ua*|tail -1|cut -d " " -f9`

cat $laststatfile | head -1 > /tngbench_share/temp_call_metrics.txt
cat $laststatfile | tail -1 >> /tngbench_share/temp_call_metrics.txt

python /python_stat_processor.py /tngbench_share/temp_call_metrics.txt /tngbench_share/final_metrics_for_openimscore.txt

cat /tngbench_share/final_metrics_for_openimscore.txt | tr -s "\t" "_"| egrep "TargetRate|CallRate|CurrentCall|TotalCallCreated|FailedCall|SuccessfulCall|IncomingCall|OutgoingCall|Retransmissions|FatalErrors|Warnings|Retransmissions|DeadCallMsgs|FailedMaxUDPRetrans|FailedTcpConnect|FailedUnexpectedMessage"|tr -s "(" "_"|tr -d ")" | awk 'BEGIN {FS = ":";OFS = ": " ;} {print $1,$2}'

#cat /tngbench_share/final_metrics_for_openimscore.txt | tr -s "\t" "_"| tr -s "(" "_"|tr -d ")" | tr -d "<" |tr -d ">"|tr -d "=" | awk 'BEGIN {FS = ":";OFS = ": " ;} {print $1,$2}'


#awk 'BEGIN {FS = ":";OFS = ": " ;} {print $1,$2}'
