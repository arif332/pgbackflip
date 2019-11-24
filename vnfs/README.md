# MoP: Build VNFs


## Document History

```
Document History:
2019-08-15  V1  Arif  "Initial deployment at localhost"
2019-09-21  V2  Arif  "Build all vnfs using script"
```



## Introduction

 This Method of Procedure (MoP) will deploy all the VNFs using script and push to docker hub. 



## VNFs deployment Procedure

1. #### Clone repository 

   ```bash
   git clone https://github.com/arif332/tng-bench-experiments.git
   ```

2. #### Navigate to folder

   ```bash
   cd tng-bench-experiments/vnfs
   ```

3. #### Build the containers

   ```bash
   sudo ./build.sh
   ```

4. #### Push containers to docker hub

   ```bash
   sudo docker login
   sudo ./push.sh
   ```
   
   
   
5. #### Check docker images

   ```bash
   sudo docker ps
   sudo docker images
   
   ```
