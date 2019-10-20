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

http://cryingengineers.blogspot.com/2011/09/how-to-install-open-ims-core-in-ubuntu.html

http://users.fh-salzburg.ac.at/~tpfeiffe/doku/cnm/InstallationGuideOpenIMSCore.pdf
```


sip client can be use to test registration/call

```bash
https://github.com/SIPp/sipp
http://sipp.sourceforge.net/doc/reference.html
http://sipp.sourceforge.net/ims_bench/reference.html#Installation
```

Thesis doc regarding OpenIMS and interoperability with Asterisk/SIP -

```bash
https://core.ac.uk/download/pdf/52058622.pdf
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

      

3. #### Run Docker Image

   Run docker image as like below command -

   ```bash
   docker run -h openimscore --name openimscore -itd arif332/openimscore-allinone
   
   docker exec -it openimscore bash
   
   ```

   

4. #### Start Application  

   Application will start automatically. If it's not started automatically then following script can be launch to start application -

   ```bash
   service mysql start
   /opt/OpenIMSCore/fhoss.sh &
   /opt/OpenIMSCore/scscf.sh &
   /opt/OpenIMSCore/pcscf.sh &
   /opt/OpenIMSCore/icscf.sh &
   ```

5. ####  Access Application

   ```bash
   #http://hssAdmin:hss@localhost:8080/hss.web.console/
   
   #As having issue to access tomcat webserver from external, so installed nginx as reverse proxy to access hss web gui.

   http://localhost or http://external_ip_docker_host
   	User: hss/hss
   	Admin: hssAdmin/hss
   ```
   
   



## OpenIMSCore Configuration

OpenIMSCore documentation link -

```bash
http://openimscore.sourceforge.net/docs/ser_ims/index.html
```

Create new user with script -

```bash
 /opt/OpenIMSCore/FHoSS/config/DiameterPeerHSS.xml
 /opt/OpenIMSCore/FHoSS/config/hss.properties
 
 ./add-imscore-user_newdb.sh -u tran 
 ./add-imscore-user.sh -u tran
 root@openimscore5:/opt/OpenIMSCore# more add-user-tran.sql 
 
```



Modify scscf.cfg as per below information -

```bash
Then you have two options for the S-CSCF to trigger an MD5 authentication
Modify the client to send a parameter "algorithm=MD5" in the Authorization header in the first unauthorized REGISTER.
Or modify the scscf.cfg and enable the MD5 authorization as the default authentication method instead of AKAv1-MD5.

#Modify registration_default_algorithm & registration_qop in scscf.cfg as like below
root@openimscore5:/opt/OpenIMSCore# grep modparam scscf.cfg |grep -i md5
#modparam("scscf","registration_default_algorithm","AKAv1-MD5")
#modparam("scscf","registration_default_algorithm","AKAv2-MD5")
modparam("scscf","registration_default_algorithm","MD5")
#modparam("scscf","registration_default_algorithm","TISPAN-HTTP_DIGEST_MD5")
root@openimscore5:/opt/OpenIMSCore# grep modparam scscf.cfg |grep -i qop
#modparam("scscf","registration_qop","auth,auth-int")
modparam("scscf","registration_qop","")

```



Modify listen address in pcscf.cfg otherwise sipp client will not able to communicate with OpenIMSCore Server

```bash
#modify listen address as like below for file scscf.cfg, icscf.cfg and pcscf.cfg so that sipp client can talk with OpenIMSCore Server, otherwise Destination unreachable(Port unreachable) msg will be seen in tcmpdump trace 

#listen=127.0.0.1
listen=0.0.0.0
port=4060

```





## SIP Client Docker Image




Install sip client software manually -

```bash
cd /usr/local/src
git clone https://github.com/SIPp/sipp.git
cd sipp
apt-get install -y pkg-config dh-autoreconf ncurses-dev build-essential libssl-dev libpcap-dev libncurses5-dev libsctp-dev lksctp-tools
./build.sh --with-pcap --with-sctp --with-openssl
cp sipp /usr/local/bin/
```



Build docker container -

```bash
git clone https://github.com/arif332/tng-bench-experiments.git
cd tng-bench-experiments/vnfs/ims-client-mp

docker build -t arif332/ims-client-mp .
```

Push ims-client-mp to docker hub -

```bash
docker push arif332/ims-client-mp
```



Cheat sheet for SIPP -

```bash
http://tomeko.net/other/sipp/sipp_cheatsheet.php?lang=en
```






## Testing with SIP Client (IMS Client)



```bash
#testing configuration script from openimscore 
http://openimscore.sourceforge.net/?q=emergency_testing_guide
#sip cheatsheet
http://tomeko.net/other/sipp/sipp_cheatsheet.php?lang=en
```



Youtube video for the SIPP integration work -

```bash
https://www.youtube.com/watch?v=ifco0-HGljI
https://www.youtube.com/watch?v=TZMrPJM4HMc
```



Similar ip and port communication issue -

```bash
https://github.com/moby/moby/issues/32168

solution for this issue is to listen pcscf on address 0.0.0.0:4060

modify listen address as like below for file scscf.cfg, icscf.cfg and pcscf.cfg

#listen=127.0.0.1
listen=0.0.0.0
port=4060

```



Subscriber registration from SIPP Client using below command - 


```bash
#sip test command from client
sipp -sf non_em_reg_alice.xml 172.17.0.2:4060  -p 3061 -m 1
```



sipp test message -

```bash
                                           ------------------------------ Scenario Screen -------- [1-9]: Change Screen --
  Call-rate(length)   Port   Total-time  Total-calls  Remote-host
  10.0(0 ms)/1.000s   3061       0.00 s            0  172.17.0.2:4060(UDP)

  0 new calls during 0.000 s period      0 ms scheduler resolution
  0 calls (limit 30)                     Peak was 0 calls, after 0 s
  0 Running, 0 Paused, 0 Woken up
  0 dead call msg (discarded)            0 out-of-call msg (discarded)        
  3 open sockets                        

                                 Messages  Retrans   Timeout   Unexpected-Msg
    REGISTER ---------->         0         0         0                  
         401 <----------  E-RTD1 0         0         0         0        
    REGISTER ---------->         0         0         0                  
         200 <----------         0         0         0         0        
------ [+|-|*|/]: Adjust rate ---- [q]: Soft exit ---- [p]: Pause traffic -----

------------------------------ Scenario Screen -------- [1-9]: Change Screen --
  Call-rate(length)   Port   Total-time  Total-calls  Remote-host
  10.0(0 ms)/1.000s   3061       0.14 s            1  172.17.0.2:4060(UDP)

  Call limit reached (-m 1), 0.140 s period  1 ms scheduler resolution
  0 calls (limit 30)                     Peak was 1 calls, after 0 s
  0 Running, 4 Paused, 1 Woken up
  0 dead call msg (discarded)            0 out-of-call msg (discarded)        
  0 open sockets                        

                                 Messages  Retrans   Timeout   Unexpected-Msg
    REGISTER ---------->         1         0         0                  
         401 <----------  E-RTD1 0         0         0         1        
    REGISTER ---------->         0         0         0                  
         200 <----------         0         0         0         0        
------------------------------ Test Terminated --------------------------------


------------------------------ Scenario Screen -------- [1-9]: Change Screen --
  Call-rate(length)   Port   Total-time  Total-calls  Remote-host
  10.0(0 ms)/1.000s   3061       0.14 s            1  172.17.0.2:4060(UDP)

  Call limit reached (-m 1), 0.000 s period  0 ms scheduler resolution
  0 calls (limit 30)                     Peak was 1 calls, after 0 s
  0 Running, 4 Paused, 0 Woken up
  0 dead call msg (discarded)            0 out-of-call msg (discarded)        
  0 open sockets                        

                                 Messages  Retrans   Timeout   Unexpected-Msg
    REGISTER ---------->         1         0         0                  
         401 <----------  E-RTD1 0         0         0         1        
    REGISTER ---------->         0         0         0                  
         200 <----------         0         0         0         0        
------------------------------ Test Terminated --------------------------------


----------------------------- Statistics Screen ------- [1-9]: Change Screen --
  Start Time             | 2019-10-20	19:53:29.934816	1571601209.934816         
  Last Reset Time        | 2019-10-20	19:53:30.076468	1571601210.076468         
  Current Time           | 2019-10-20	19:53:30.076676	1571601210.076676         
-------------------------+---------------------------+--------------------------
  Counter Name           | Periodic value            | Cumulative value
-------------------------+---------------------------+--------------------------
  Elapsed Time           | 00:00:00:000000           | 00:00:00:141000          
  Call Rate              |    0.000 cps              |    7.092 cps             
-------------------------+---------------------------+--------------------------
  Incoming call created  |        0                  |        0                 
  OutGoing call created  |        0                  |        1                 
  Total Call created     |                          |        1                 
  Current Call           |        0                  |                          
-------------------------+---------------------------+--------------------------
  Successful call        |        0                  |        0                 
  Failed call            |        0                  |        1                 
-------------------------+---------------------------+--------------------------
  Response Time 1        | 00:00:00:000000           | 00:00:00:000000          
  Call Length            | 00:00:00:000000           | 00:00:00:036000          
------------------------------ Test Terminated --------------------------------


2019-10-20	19:53:30.076000	1571601210.076000: Aborting call on unexpected message for Call-Id '1-31@172.17.0.3': while expecting '401' (index 1), received 'SIP/2.0 478 Unresolvable destination (478/TM)
Via: SIP/2.0/UDP 172.17.0.3:3061;branch=z9hG4bK-31-1-0;rport=3061
From: "alice" <sip:alice@open-ims.test>;tag=1
To: "alice" <sip:alice@open-ims.test>;tag=5d140a338aa6e1dd545b3496380067c9-c30a
Call-ID: reg///1-31@172.17.0.3
CSeq: 1 REGISTER
Server: Sip EXpress router (2.1.0-dev1 OpenIMSCore (x86_64/linux))
Content-Length: 0
Warning: 392 0.0.0.0:4060 "Noisy feedback tells:  pid=562 req_src_ip=172.17.0.3 req_src_port=3061 in_uri=sip:open-ims.test out_uri=sip:open-ims.test via_cnt==1"

'
root@ims-client-mp:/ims-test-conf# 
root@ims-client-mp:/ims-test-conf# 

```

