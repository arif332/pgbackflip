# Deploment: Freeradius (vAAA) vnf


## Document History

```
Author: Arif
Document History:
2019-08-15	V1 Initial deployment at localhost
```



## Introduction

 FreeRADIUS is a open source implementation of RADIUS protocol which allows authentication and authorization for a network to be centralized. 



## Freeradius(vAAA) deployment Procedure

1. #### Clone repository 

   ```bash
   git clone https://github.com/arif332/pgbackflip.git
   ```

2. #### Navigate to folder

   ```bash
   cd pgbackflip/vnf_deploy/vAAA
   ```

3. #### Build the containers

   ```bash
   docker-compose up --build -d
   ```

4. #### Free radius authentication test

   ```bash
   docker exec -it vaaa_server radtest bob test 127.0.0.1 0 testing123
   
   root@ariflindesk1:/home/arif/gitRepos/pgbackflip/vnf_deploy# docker exec -it vaaa2 radtest bob test 127.0.0.1 0 testing123
   Sent Access-Request Id 84 from 0.0.0.0:38296 to 127.0.0.1:1812 length 73
   	User-Name = "bob"
   	User-Password = "test"
   	NAS-IP-Address = 172.21.0.7
   	NAS-Port = 0
   	Message-Authenticator = 0x00
   	Cleartext-Password = "test"
   Received Access-Accept Id 84 from 127.0.0.1:1812 to 127.0.0.1:38296 length 20
   root@ariflindesk1:/home/arif/gitRepos/pgbackflip/vnf_deploy#
   
   ```
