# Deployment OpenIMSCore  


## Document History

```
Author: Arif
Document History:
2019-09-22	V1	collecting information
2019-09-27	V2	resolve ser application start issue
2019-09-29	V3	finalize automatic docker build config file and procedure
```



## Introduction

 This doc is gathering information about openIMScore which is originally developed by [Fraunhofer FOKUS](http://www.fokus.fraunhofer.de/) [NGNI](http://www.fokus.fraunhofer.de/go/ngni). There is no official docker image available, so we have compile OpenIMSCore source code manually and build docker image. 



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

Installation guide and source code can be found in below link -

```bash
http://openimscore.sourceforge.net/?q=installation_guide
```


Below document also describe, how to configure OpenIMSCore on different machine - 

```bash
https://sites.google.com/site/haninemati/developing-ims/using-openimscore-on-different-machine
https://sites.google.com/site/haninemati/developing-ims/installing-openimscore-on-ubunto-12-04

http://raziyabhayani.blogspot.com/2009/07/openimscore-installation-on-ubuntu-904.html

https://code.google.com/archive/p/multi-p2p/wikis/InstallOpenIMSCoreandMobicentsAS.wiki
```


sip clinet can be use to test registration/call

```bash
http://sipp.sourceforge.net/doc/reference.html
```



Openbatton project also did an implementation which configuration files are available in below location -

```bash
https://github.com/openbaton/openimscore-packages
```



## Local Implementation Steps

1. #### Create docker image locally

   Content of Dockerfile file is like below - 

   ```bash
   
   git clone https://github.com/arif332/tng-bench-experiments.git
   
   #Note: Now download java jdk-7u80-linux-x64.tar.gz from oracle website and place under tng-bench-experiments/vnfs/openIMScore. Docker build configuration file is based on the java jdk 1.7 u80.
   
   cd tng-bench-experiments/vnfs
   sudo ./imsbuild.sh
   
   ```
   
   
   
2. #### Download OpenIMSCore image from docker hub

   Docker image is build using above procedure and image is available in docker hub which can be pull any time.

   ```bash
   docker pull arif332/openimscore-allinone
   ```

      

3. #### Start Application  

   Application will start automatically. If it's not started automatically then following script can be launch to start application -

   ```bash
   service mysql start
   /opt/OpenIMSCore/fhoss.sh &
   /opt/OpenIMSCore/scscf.sh &
   /opt/OpenIMSCore/pcscf.sh &
   /opt/OpenIMSCore/icscf.sh &
   ```

4. ####  Access Application

   ```bash
   http://hssAdmin:hss@localhost:8080/hss.web.console/
   
   ```

   



## OpenIMSCore Configuration







## SIP Clinet Integration

