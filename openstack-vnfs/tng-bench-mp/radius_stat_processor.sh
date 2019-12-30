#!/bin/bash

cat /tngbench_share/probe_freeradius_stat.txt|tr -s "=" ":"|egrep "FreeRADIUS-Total-Access-Requests|FreeRADIUS-Total-Access-Accepts|FreeRADIUS-Total-Access-Rejects|FreeRADIUS-Total-Auth-Responses|FreeRADIUS-Total-Auth-Responses"|awk '{$1=$1};1'


