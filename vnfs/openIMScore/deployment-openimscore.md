# Deployment OpenIMSCore  


## Document History

```
Author: Arif
Document History:
2019-09-22	V1	collecting information
2019-09-27	V2	solve ser application start issue
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

http://raziyabhayani.blogspot.com/2009/07/openimscore-installation-on-ubuntu-904.html
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
   #update & install software
   apt-get update
   apt-get install -y build-essential software-properties-common \ 
   	subversion ant curl \
   	gcc-4.8 g++-4.8 \ 
   	flex bison \
   	libxml2-dev \
   	libcurl4-openssl-dev \
   	libmysqld-dev \
   	mysql-server \
   	ipsec-tools
   	
   sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
   
   --key package to run ser application *** initially tried with gcc7/8
   sudo apt install gcc-4.8 g++-4.8   
   update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
   
   #install oracle java 1.7
   docker cp jdk-7u80-linux-x64.tar.gz openimscore:/tmp
   tar zxvf jdk-7u80-linux-x64.tar.gz
   export JAVA_HOME=/opt/jdk1.7.0_80
   
   update-alternatives  --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 150
   update-alternatives  --config java
   update-alternatives  --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 150
   update-alternatives  --config javac
   
   wget http://ftp.halifax.rwth-aachen.de/apache//ant/binaries/apache-ant-1.9.14-bin.tar.gz
   tar zxvf apache-ant-1.9.14-bin.tar.gz
   export ANT_HOME="/opt/apache-ant-1.9.14"
   export PATH=$PATH:$ANT_HOME/bin
   
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
   
   make install-libs all
   
   cd ..
   mysql -u root -p < FHoSS/scripts/hss_db.sql 
   mysql -u root -p < FHoSS/scripts/userdata.sql
   mysql -u root -p < ser_ims/cfg/icscf.sql
   
   #copy config file
   cd /opt/OpenIMSCore
   cp ser_ims/cfg/*.cfg . 	
   cp ser_ims/cfg/*.xml .
   cp ser_ims/cfg/*.sh .
   
   #another import task to copy lib file to local folder, other wise pcscf.sh and scscf.sh is not starting 
   cp /opt/OpenIMSCore/ser_ims/lib/*/*.so  /usr/local/lib/ser
   
   ```


   ```bash
   
   
   ```

   

3. #### Start Application  

   ```bash
   cd /opt/OpenIMSCore
   ./scscf.sh 
   ```

4. ####  Error logs while starting application

   ```bash
   root@openimscore:/opt/OpenIMSCore# ./pcscf.sh 
   pfkey_open: Operation not permitted
   pfkey_open: Operation not permitted
    0(662) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/dialog/dialog.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(662) parse error (37,13-14): failed to load module
    0(662) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/pcscf/pcscf.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(662) parse error (42,13-14): failed to load module
    0(662) set_mod_param_regex: No module matching <pcscf> found
   ...
   
   ```

   


   lib install failed

   ```bash
   root@openimscore:/opt/OpenIMSCore/ser_ims# make install-libs all 
   Makefile.defs:659: You are using an old and unsupported gcc version  (8.04.x), compile at your own risk!
   make -C lib -f Makefile.ser install
   make[1]: Entering directory '/opt/OpenIMSCore/ser_ims/lib'
   Making install in binrpc
   make[2]: Entering directory '/opt/OpenIMSCore/ser_ims/lib/binrpc'
   /usr/local/lib/ser/libbinrpc.so
   make[2]: /usr/local/lib/ser/libbinrpc.so: Command not found
   ../Makefile.ser.defs:26: recipe for target 'install' failed
   make[2]: *** [install] Error 127
   make[2]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib/binrpc'
   Makefile.ser:46: recipe for target 'binrpc' failed
   make[1]: [binrpc] Error 2 (ignored)
   Making install in cds
   make[2]: Entering directory '/opt/OpenIMSCore/ser_ims/lib/cds'
   /usr/local/lib/ser/lib_ser_cds.so
   make[2]: /usr/local/lib/ser/lib_ser_cds.so: Command not found
   ../Makefile.ser.defs:26: recipe for target 'install' failed
   make[2]: *** [install] Error 127
   make[2]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib/cds'
   Makefile.ser:46: recipe for target 'cds' failed
   make[1]: [cds] Error 2 (ignored)
   Making install in xcap
   make[2]: Entering directory '/opt/OpenIMSCore/ser_ims/lib/xcap'
   /usr/local/lib/ser/lib_ser_xcap.so
   make[2]: /usr/local/lib/ser/lib_ser_xcap.so: Command not found
   ../Makefile.ser.defs:26: recipe for target 'install' failed
   make[2]: *** [install] Error 127
   make[2]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib/xcap'
   Makefile.ser:46: recipe for target 'xcap' failed
   make[1]: [xcap] Error 2 (ignored)
   Making install in presence
   make[2]: Entering directory '/opt/OpenIMSCore/ser_ims/lib/presence'
   /usr/local/lib/ser/lib_ser_presence.so
   make[2]: /usr/local/lib/ser/lib_ser_presence.so: Command not found
   ../Makefile.ser.defs:26: recipe for target 'install' failed
   make[2]: *** [install] Error 127
   make[2]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib/presence'
   Makefile.ser:46: recipe for target 'presence' failed
   make[1]: [presence] Error 2 (ignored)
   Making install in lost
   make[2]: Entering directory '/opt/OpenIMSCore/ser_ims/lib/lost'
   /usr/local/lib/ser/lib_lost_client.so
   make[2]: /usr/local/lib/ser/lib_lost_client.so: Command not found
   ../Makefile.ser.defs:26: recipe for target 'install' failed
   make[2]: *** [install] Error 127
   make[2]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib/lost'
   Makefile.ser:46: recipe for target 'lost' failed
   make[1]: [lost] Error 2 (ignored)
   make[1]: Leaving directory '/opt/OpenIMSCore/ser_ims/lib'
   make -C lib -f Makefile.ser
   
   ```

   

5. #### start scscf.sh

   

   ```bash
   root@openimscore:/opt/OpenIMSCore# ./scscf.sh 
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/dialog/dialog.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(522) parse error (32,13-14): failed to load module
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/scscf/scscf.so>: lib_ser_cds.so: cannot open shared object file: No such file or directory
    0(522) parse error (40,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <scscf> found
    ...
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/isc/isc.so>: /opt/OpenIMSCore/ser_ims/modules/isc/isc.so: undefined symbol: isc_mark_drop_route
    0(522) parse error (106,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <isc> found
   ...
    0(522) ERROR: load_module: could not open module </opt/OpenIMSCore/ser_ims/modules/cdp/cdp.so>: /opt/OpenIMSCore/ser_ims/modules/cdp/cdp.so: undefined symbol: log_dp_config
    0(522) parse error (114,13-14): failed to load module
    0(522) set_mod_param_regex: No module matching <cdp> found
    0(522) parse error (115,18-19): Can't set module parameter
    0(522) parse error (146,42-43): unknown command, missing loadmodule?
   ...
   
   ERROR: bad config file (101 errors)
   
   ------ Semaphore Arrays --------
   key        semid      owner      perms      nsems     
   
   root@openimscore:/opt/OpenIMSCore# 
   root@openimscore:/opt/OpenIMSCore# 
   
   ```

   

6. #### Imported docker

   ```bash
   docker pull openims/openims:1.1
   docker pull openims/pcscf:1.0
   docker pull openims/scscf:1.0
   docker pull openims/icscf:1.0
   
   docker pull openims/openimscore
   
   docker run -itd openims/openims:1.1
   docker exec -it a03f15896ce8 bash
   
   /bin/bash /opt/OpenIMSCore/icscf.sh
   
   ```

   

7. #### Copy lib file to local

   ```bash
   /opt/OpenIMSCore/ser_ims/lib/binrpc/libbinrpc.so  /opt/OpenIMSCore/ser_ims/lib/lost/lib_lost_client.so       /opt/OpenIMSCore/ser_ims/lib/xcap/lib_ser_xcap.so
   /opt/OpenIMSCore/ser_ims/lib/cds/lib_ser_cds.so   /opt/OpenIMSCore/ser_ims/lib/presence/lib_ser_presence.so
   
   
   cp /opt/OpenIMSCore/ser_ims/lib/*/*.so  /usr/local/lib/ser
   
   cp /opt/OpenIMSCore/ser_ims/lib/lost/lib_lost_client.so /usr/local/lib/ser        
   cp /opt/OpenIMSCore/ser_ims/lib/xcap/lib_ser_xcap.so  /usr/local/lib/ser
   cp /opt/OpenIMSCore/ser_ims/lib/cds/lib_ser_cds.so /usr/local/lib/ser 
   cp /opt/OpenIMSCore/ser_ims/lib/presence/lib_ser_presence.so /usr/local/lib/ser
   
   
   ```

   

8. fhoss.sh

   ```bash
   
   root@openimscore:/opt/OpenIMSCore# ./fhoss.sh 
   Building Classpath
   Classpath is lib/xml-apis.jar:lib/xercesImpl.jar:lib/xerces-2.4.0.jar:lib/xalan-2.4.0.jar:lib/tomcat-util.jar:lib/tomcat-http.jar:lib/tomcat-coyote.jar:lib/struts.jar:lib/servlets-default.jar:lib/servlet-api.jar:lib/naming-resources.jar:lib/naming-factory.jar:lib/mysql-connector-java-3.1.12-bin.jar:lib/mx4j-3.0.1.jar:lib/log4j.jar:lib/junitee.jar:lib/junit.jar:lib/jta.jar:lib/jsp-api.jar:lib/jmx.jar:lib/jdp.jar:lib/jasper-runtime.jar:lib/jasper-compiler.jar:lib/jasper-compiler-jdt.jar:lib/hibernate3.jar:lib/ehcache-1.1.jar:lib/dom4j-1.6.1.jar:lib/commons-validator.jar:lib/commons-modeler.jar:lib/commons-logging.jar:lib/commons-logging-1.0.4.jar:lib/commons-lang.jar:lib/commons-fileupload.jar:lib/commons-el.jar:lib/commons-digester.jar:lib/commons-collections-3.1.jar:lib/commons-beanutils.jar:lib/cglib-2.1.3.jar:lib/catalina.jar:lib/catalina-optional.jar:lib/c3p0-0.9.1.jar:lib/base64.jar:lib/asm.jar:lib/asm-attrs.jar:lib/antlr-2.7.6.jar:lib/FHoSS.jar::log4j.properties:..
   [main] INFO  de.fhg.fokus.hss.main.TomcatServer  - Tomcat-Server is started.
   [main] INFO  org.apache.catalina.startup.Embedded  - Starting tomcat server
   [main] INFO  org.apache.catalina.core.StandardEngine  - Starting Servlet Engine: Apache Tomcat/5.5.9
   [main] INFO  org.apache.coyote.http11.Http11Protocol  - Initializing Coyote HTTP/1.1 on http-127.0.0.1-8080
   [main] INFO  org.apache.coyote.http11.Http11Protocol  - Starting Coyote HTTP/1.1 on http-127.0.0.1-8080
   [main] WARN  org.apache.catalina.connector.MapperListener  - Unknown default host: 127.0.0.1
   [main] INFO  org.apache.catalina.core.StandardHost  - XML validation disabled
   [main] INFO  de.fhg.fokus.hss.web.servlet.ResponseFilter  - Response Filter Initialisation!
   log4j:WARN No appenders could be found for logger (org.apache.catalina.loader.WebappClassLoader).
   log4j:WARN Please initialize the log4j system properly.
   [main] INFO  org.apache.struts.tiles.TilesPlugin  - Tiles definition factory loaded for module ''.
   [main] INFO  org.apache.struts.validator.ValidatorPlugIn  - Loading validation rules file from '/WEB-INF/validator-rules.xml'
   [main] INFO  org.apache.struts.validator.ValidatorPlugIn  - Loading validation rules file from '/WEB-INF/validation.xml'
   [main] INFO  de.fhg.fokus.hss.main.TomcatServer  - WebConsole of FHoSS was started !
   [main] INFO  org.hibernate.cfg.Environment  - Hibernate 3.2.1
   [main] INFO  org.hibernate.cfg.Environment  - loaded properties from resource hibernate.properties: {hibernate.c3p0.timeout=3600, hibernate.connection.driver_class=com.mysql.jdbc.Driver, hibernate.connection.isolation=1, hibernate.c3p0.max_statements=0, hibernate.c3p0.max_size=30, hibernate.dialect=org.hibernate.dialect.MySQLDialect, hibernate.c3p0.idle_test_period=1200, hibernate.c3p0.min_size=1, hibernate.connection.username=hss, hibernate.c3p0.acquire_increment=1, hibernate.connection.url=jdbc:mysql://127.0.0.1:3306/hss_db, hibernate.bytecode.use_reflection_optimizer=false, hibernate.connection.password=****}
   [main] INFO  org.hibernate.cfg.Environment  - Bytecode provider name : cglib
   [main] INFO  org.hibernate.cfg.Environment  - using JDK 1.4 java.sql.Timestamp handling
   [main] INFO  org.hibernate.cfg.Configuration  - configuring from resource: /hibernate.cfg.xml
   [main] INFO  org.hibernate.cfg.Configuration  - Configuration resource: /hibernate.cfg.xml
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/ApplicationServer.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.ApplicationServer -> application_server
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/CapabilitiesSet.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.CapabilitiesSet -> capabilities_set
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/Capability.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.Capability -> capability
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/ChargingInfo.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.ChargingInfo -> charging_info
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/DSAI_IMPU.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.DSAI_IMPU -> dsai_impu
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/DSAI_IFC.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.DSAI_IFC -> dsai_ifc
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/DSAI.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.DSAI -> dsai
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IFC.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IFC -> ifc
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IMPI_IMPU.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IMPI_IMPU -> impi_impu
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IMPI.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IMPI -> impi
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IMPU.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IMPU -> impu
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IMPU_VisitedNetwork.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IMPU_VisitedNetwork -> impu_visited_network
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/IMSU.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.IMSU -> imsu
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/Preferred_SCSCF_Set.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.Preferred_SCSCF_Set -> preferred_scscf_set
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/CxEvents.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.CxEvents -> cx_events
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/Shared_IFC_Set.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.Shared_IFC_Set -> shared_ifc_set
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/ShNotification.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.ShNotification -> sh_notification
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/ShSubscription.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.ShSubscription -> sh_subscription
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/SP_IFC.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.SP_IFC -> sp_ifc
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/SP_Shared_IFC_Set.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.SP_Shared_IFC_Set -> sp_shared_ifc_set
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/SP.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.SP -> sp
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/SPT.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.SPT -> spt
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/TP.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.TP -> tp
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/VisitedNetwork.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.VisitedNetwork -> visited_network
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/RepositoryData.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.RepositoryData -> repository_data
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/AliasesRepositoryData.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.AliasesRepositoryData -> aliases_repository_data
   [main] INFO  org.hibernate.cfg.Configuration  - Reading mappings from resource : mappings/Zh_USS.hbm.xml
   [main] INFO  org.hibernate.cfg.HbmBinder  - Mapping class: de.fhg.fokus.hss.db.model.Zh_USS -> zh_uss
   [main] INFO  org.hibernate.cfg.Configuration  - Configured SessionFactory: foo
   [main] INFO  org.hibernate.connection.C3P0ConnectionProvider  - C3P0 using driver: com.mysql.jdbc.Driver at URL: jdbc:mysql://127.0.0.1:3306/hss_db
   [main] INFO  org.hibernate.connection.C3P0ConnectionProvider  - Connection properties: {user=hss, password=****, autocommit=false}
   [main] INFO  org.hibernate.connection.C3P0ConnectionProvider  - autocommit mode: false
   [main] INFO  com.mchange.v2.log.MLog  - MLog clients using log4j logging.
   [main] INFO  com.mchange.v2.c3p0.C3P0Registry  - Initializing c3p0-0.9.1 [built 16-January-2007 14:46:42; debug? true; trace: 10]
   [main] INFO  org.hibernate.connection.C3P0ConnectionProvider  - JDBC isolation level: READ_UNCOMMITTED
   [main] INFO  com.mchange.v2.c3p0.impl.AbstractPoolBackedDataSource  - Initializing c3p0 pool... com.mchange.v2.c3p0.PoolBackedDataSource@6034bc46 [ connectionPoolDataSource -> com.mchange.v2.c3p0.WrapperConnectionPoolDataSource@95dddced [ acquireIncrement -> 1, acquireRetryAttempts -> 60, acquireRetryDelay -> 1000, autoCommitOnClose -> false, automaticTestTable -> null, breakAfterAcquireFailure -> false, checkoutTimeout -> 0, connectionCustomizerClassName -> null, connectionTesterClassName -> com.mchange.v2.c3p0.impl.DefaultConnectionTester, debugUnreturnedConnectionStackTraces -> false, factoryClassLocation -> null, forceIgnoreUnresolvedTransactions -> false, identityToken -> 1bqq1hfa5wh0seo4zmyo2|139ce6db, idleConnectionTestPeriod -> 1200, initialPoolSize -> 1, maxAdministrativeTaskTime -> 0, maxConnectionAge -> 0, maxIdleTime -> 3600, maxIdleTimeExcessConnections -> 0, maxPoolSize -> 30, maxStatements -> 0, maxStatementsPerConnection -> 0, minPoolSize -> 1, nestedDataSource -> com.mchange.v2.c3p0.DriverManagerDataSource@1dfde13c [ description -> null, driverClass -> null, factoryClassLocation -> null, identityToken -> 1bqq1hfa5wh0seo4zmyo2|22c296dd, jdbcUrl -> jdbc:mysql://127.0.0.1:3306/hss_db, properties -> {user=******, password=******, autocommit=false} ], preferredTestQuery -> null, propertyCycle -> 0, testConnectionOnCheckin -> false, testConnectionOnCheckout -> false, unreturnedConnectionTimeout -> 0, usesTraditionalReflectiveProxies -> false; userOverrides: {} ], dataSourceName -> null, factoryClassLocation -> null, identityToken -> 1bqq1hfa5wh0seo4zmyo2|519bc06f, numHelperThreads -> 3 ]
   [main] INFO  org.hibernate.cfg.SettingsFactory  - RDBMS: MySQL, version: 5.7.27-0ubuntu0.18.04.1
   [main] INFO  org.hibernate.cfg.SettingsFactory  - JDBC driver: MySQL-AB JDBC Driver, version: mysql-connector-java-3.1.12 ( $Date: 2005-11-17 15:53:48 +0100 (Thu, 17 Nov 2005) $, $Revision$ )
   [main] INFO  org.hibernate.dialect.Dialect  - Using dialect: org.hibernate.dialect.MySQLDialect
   [main] INFO  org.hibernate.transaction.TransactionFactoryFactory  - Using default transaction strategy (direct JDBC transactions)
   [main] INFO  org.hibernate.transaction.TransactionManagerLookupFactory  - No TransactionManagerLookup configured (in JTA environment, use of read-write or transactional second-level cache is not recommended)
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Automatic flush during beforeCompletion(): disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Automatic session close at end of transaction: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - JDBC batch size: 15
   [main] INFO  org.hibernate.cfg.SettingsFactory  - JDBC batch updates for versioned data: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Scrollable result sets: enabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - JDBC3 getGeneratedKeys(): enabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Connection release mode: auto
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Maximum outer join fetch depth: 2
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Default batch fetch size: 1
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Generate SQL with comments: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Order SQL updates by primary key: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Query translator: org.hibernate.hql.ast.ASTQueryTranslatorFactory
   [main] INFO  org.hibernate.hql.ast.ASTQueryTranslatorFactory  - Using ASTQueryTranslatorFactory
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Query language substitutions: {}
   [main] INFO  org.hibernate.cfg.SettingsFactory  - JPA-QL strict compliance: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Second-level cache: enabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Query cache: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Cache provider: org.hibernate.cache.NoCacheProvider
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Optimize cache for minimal puts: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Structured second-level cache entries: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Statistics: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Deleted entity synthetic identifier rollback: disabled
   [main] INFO  org.hibernate.cfg.SettingsFactory  - Default entity-mode: pojo
   [main] INFO  org.hibernate.impl.SessionFactoryImpl  - building session factory
   [main] INFO  org.hibernate.impl.SessionFactoryObjectFactory  - Factory name: foo
   [main] INFO  org.hibernate.util.NamingHelper  - JNDI InitialContext properties:{}
   [main] INFO  org.hibernate.impl.SessionFactoryObjectFactory  - Bound factory to JNDI name: foo
   [main] WARN  org.hibernate.impl.SessionFactoryObjectFactory  - InitialContext did not implement EventContext
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - Bean style constructor called, don't forget to configure!
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - FQDN: hss.open-ims.test
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - Realm: open-ims.test
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - Vendor_ID : 10415
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - Product Name: JavaDiameterPeer
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - AcceptUnknwonPeers: true
   [main] INFO  de.fhg.fokus.diameter.DiameterPeer.DiameterPeer  - DropUnknownOnDisconnect: true
   [main] INFO  de.fhg.fokus.hss.main.HSSContainer  - 
   Type "exit" to stop FHoSS!
   [Thread-24] ERROR de.fhg.fokus.diameter.DiameterPeer.peer.StateMachine  - StateMachine: Peer icscf.open-ims.test:3869 not responding to connection attempt 
   [Thread-24] ERROR de.fhg.fokus.diameter.DiameterPeer.peer.StateMachine  - StateMachine: Peer scscf.open-ims.test:3870 not responding to connection attempt 
   
   [main] INFO  de.fhg.fokus.hss.main.HSSContainer  - 
   Type "exit" to stop FHoSS!
   [Thread-24] ERROR de.fhg.fokus.diameter.DiameterPeer.peer.StateMachine  - StateMachine: Peer icscf.open-ims.test:3869 not responding to connection attempt 
   [Thread-24] ERROR de.fhg.fokus.diameter.DiameterPeer.peer.StateMachine  - StateMachine: Peer scscf.open-ims.test:3870 not responding to connection attempt 
   
   
   ```

   

9. 


