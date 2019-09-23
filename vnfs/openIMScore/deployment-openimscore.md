# Deployment OpenIMSCore  


## Document History

```
Author: Arif
Document History:
2019-09-22	V1	collecting information
```



## Introduction

 This doc is gathering information about openIMScore which is originally developed by [Fraunhofer FOKUS](http://www.fokus.fraunhofer.de/) [NGNI](http://www.fokus.fraunhofer.de/go/ngni). There is no official docker image available, so we are trying to compile OpenIMSCore source code manually in docker image. 



### Keywords

```bash
HSS 	Home Subscribe Server
CSCF	Call Session Control Functions
SCSCF	Serving-CSCF Module
PCSCF	Proxy-CSCF Module
ICSCF 	Interrogating-CSCF Module
SER		SIP Express Router 
```



### Source Code and Installation Information

```bash
http://openimscore.sourceforge.net/?q=installation_guide
```



Below two document also describe, how to configure OpenIMSCore on different machine - 

```bash
https://sites.google.com/site/haninemati/developing-ims/using-openimscore-on-different-machine
https://sites.google.com/site/haninemati/developing-ims/installing-openimscore-on-ubunto-12-04
```



Openbatton project did a implementation and configuration files are available in below location -

```bash
https://github.com/openbaton/openimscore-packages
```



## Local Implementation Steps

1. #### Create docker

   Content of Dockerfile file is like below - 

   ```bash
   FROM ubuntu:latest
   # define interface names (should be the same as in VNFD)
   #ENV IFIN input
   #ENV IFOUT output
   
   #ADD start.sh start.sh
   #RUN chmod +x start.sh
   #ADD stop.sh stop.sh
   #RUN chmod +x stop.sh
   
   RUN mkdir /tngbench_share
   
   ```

   Build docker using above config file -

   ```bash
   #!/bin/bash
   set -e
   docker build -t arif332/openimscore -f openIMScore/Dockerfile openIMScore
   ```

   

   Start docker image and log to docker node -

   ```bash
   
   docker run -h openimscore --name openimscore -itd 7a1f9dcd7440 bash
   docker exec -it openimscore bash
   ```
   
   Install below software in docker image -	

   ```bash
   update software
   apt-get update
   apt install subversion
   apt-get install ant
   apt-get install build-essential
   apt-get install openjdk-8-jdk
   apt-get install mysql-server
   
   
   
   ```

2. #### Install OpenIMSCore software

   ```bash
   mkdir /opt/OpenIMSCore
   cd /opt/OpenIMSCore
   mkdir FHoSS
   
   svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS
   
   mkdir ser_ims
   svn checkout https://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
   
   #change /opt/OpenIMSCore/FHoSS/build.xml file with below -
   <javac .... includeantruntime="false" .../>
   
   export ANT_OPTS="-Dfile.encoding=utf-8"
   
   cd FHoSS
   ant compile deploy
   cd ..
   cd ser_ims
   make install-libs all 
   
   #build dependency package
   apt-get install flex bison
   apt-get install libxml2-dev
   apt-get install libmysqld-dev
   apt-get install curl
   apt-get install python-dev
   apt-get install libcurl4-openssl-dev
   
   cd ..
   mysql -u root -p < FHoSS/scripts/hss_db.sql 
   mysql -u root -p < FHoSS/scripts/userdata.sql
   
   mysql -u root -p < ser_ims/cfg/icscf.sql
   
   cd /opt/OpenIMSCore
   cp ser_ims/cfg/*.cfg . 	
   cp ser_ims/cfg/*.xml .
   cp ser_ims/cfg/*.sh .
   
   
   ```

   

3. #### Start Application  

   ```bash
   cd /opt/OpenIMSCore
   ./scscf.sh 
   ```

4. ####  Error logs while starting application

   ```bash
   root@openimscore:/opt/OpenIMSCore# ./scscf.sh 
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/dialog/dialog.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(522) parse error (32,13-14): failed to load module
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/scscf/scscf.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(522) parse error (40,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (42,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (47,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (48,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (49,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (50,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (51,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (53,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (58,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (60,19-20): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (62,20-21): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (63,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (64,23-24): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (65,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (67,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (80,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (81,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (83,20-21): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (84,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (85,23-24): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (87,19-20): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (88,20-21): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (89,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (90,21-22): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (91,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (94,17-18): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <scscf> found
    0(522) parse error (97,17-18): Can't set module parameter
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/isc/isc.so>: /opt/OpenIMSCore/ser_ims/modules/isc/isc.so: undefined symbol: isc_mark_drop_route
    0(522) parse error (106,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <isc> found
    0(522) parse error (108,18-19): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <isc> found
    0(522) parse error (109,20-21): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <isc> found
    0(522) parse error (110,21-22): Can't set module parameter
    0(522) set_mod_param_regex: No module matching <isc> found
    0(522) parse error (111,19-20): Can't set module parameter
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/cdp/cdp.so>: /opt/OpenIMSCore/ser_ims/modules/cdp/cdp.so: undefined symbol: log_dp_config
    0(522) parse error (114,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <cdp> found
    0(522) parse error (115,18-19): Can't set module parameter
    0(522) parse error (146,42-43): unknown command, missing loadmodule?
   
    0(522) parse error (167,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (167,44-45): unknown command, missing loadmodule?
   
    0(522) parse error (169,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (170,32-33): unknown command, missing loadmodule?
   
    0(522) parse error (177,24-25): unknown command, missing loadmodule?
   
    0(522) parse error (181,24-25): unknown command, missing loadmodule?
   
    0(522) parse error (188,30-31): unknown command, missing loadmodule?
   
    0(522) parse error (189,33-34): unknown command, missing loadmodule?
   
    0(522) parse error (224,31-32): unknown command, missing loadmodule?
   
    0(522) parse error (225,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (239,35-36): unknown command, missing loadmodule?
   
    0(522) parse error (242,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (243,19-20): unknown command, missing loadmodule?
   
    0(522) parse error (248,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (249,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (253,30-31): unknown command, missing loadmodule?
   
    0(522) parse error (260,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (261,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (297,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (298,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (302,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (309,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (310,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (337,23-24): unknown command, missing loadmodule?
   
    0(522) parse error (338,17-18): unknown command, missing loadmodule?
   
    0(522) parse error (340,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (341,17-18): unknown command, missing loadmodule?
   
    0(522) parse error (347,35-36): unknown command, missing loadmodule?
   
    0(522) parse error (348,39-40): unknown command, missing loadmodule?
   
    0(522) parse error (358,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (362,22-23): unknown command, missing loadmodule?
   
    0(522) parse error (363,19-20): unknown command, missing loadmodule?
   
    0(522) parse error (394,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (401,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (402,21-22): unknown command, missing loadmodule?
   
    0(522) parse error (404,24-25): unknown command, missing loadmodule?
   
    0(522) parse error (412,17-18): unknown command, missing loadmodule?
   
    0(522) parse error (415,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (424,21-22): unknown command, missing loadmodule?
   
    0(522) parse error (425,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (437,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (451,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (472,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (493,26-27): unknown command, missing loadmodule?
   
    0(522) parse error (500,22-23): unknown command, missing loadmodule?
   
    0(522) parse error (501,30-31): unknown command, missing loadmodule?
   
    0(522) parse error (513,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (538,21-22): unknown command, missing loadmodule?
   
    0(522) parse error (549,18-19): unknown command, missing loadmodule?
   
    0(522) parse error (566,20-21): unknown command, missing loadmodule?
   
    0(522) parse error (586,27-28): unknown command, missing loadmodule?
   
    0(522) parse error (593,29-30): unknown command, missing loadmodule?
   
    0(522) parse error (594,21-22): unknown command, missing loadmodule?
   
    0(522) parse error (596,24-25): unknown command, missing loadmodule?
   
    0(522) parse error (605,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (612,16-17): unknown command, missing loadmodule?
   
    0(522) parse error (632,18-19): unknown command, missing loadmodule?
   
    0(522) parse error (644,25-26): unknown command, missing loadmodule?
   
    0(522) parse error (657,28-29): unknown command, missing loadmodule?
   
    0(522) parse error (678,26-27): unknown command, missing loadmodule?
   
    0(522) parse error (683,17-18): unknown command, missing loadmodule?
   
    0(522) parse error (713,21-22): unknown command, missing loadmodule?
   
    0(522) parse error (716,18-19): unknown command, missing loadmodule?
   
    0(522) parse error (743,20-21): unknown command, missing loadmodule?
   
    0(522) parse error (795,25-26): unknown command, missing loadmodule?
   
   ERROR: bad config file (101 errors)
   
   ------ Semaphore Arrays --------
   key        semid      owner      perms      nsems     
   
   root@openimscore:/opt/OpenIMSCore# 
   root@openimscore:/opt/OpenIMSCore# 
   
   ```

   

5. 


