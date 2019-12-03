





```bash
grep FreeRADIUS-Total-Access-Requests freeradius_stat.txt

```





```bash
input_file
eceived Access-Accept Id 203 from 127.0.0.1:18121 to 127.0.0.1:59079 length 536
	FreeRADIUS-Total-Access-Requests = 52069
	FreeRADIUS-Total-Access-Accepts = 51699
	FreeRADIUS-Total-Access-Rejects = 112
	FreeRADIUS-Total-Access-Challenges = 0
	FreeRADIUS-Total-Auth-Responses = 51811
	FreeRADIUS-Total-Auth-Duplicate-Requests = 0
	FreeRADIUS-Total-Auth-Malformed-Requests = 0


python_script input_file >>output_file

cat Output_file
FreeRADIUS-Total-Access-Requests: 52069
FreeRADIUS-Total-Access-Accepts: 51699
FreeRADIUS-Total-Access-Rejects: 112
FreeRADIUS-Total-Auth-Responses: 51811


```

