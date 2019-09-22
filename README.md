# tng-bench-experiments


## Document History

```
Author: Arif
Document History:
2019-09-21	V2	Build all vnfs using script
```



## Introduction

 This Method of Procedure (MoP) will do vAAA experiments in vim-emu environments. 



## Experiments in tng-bench

1. #### Check VIM-EMU Server

   ```bash
   #login to vim-emu server and check whether server is running or not
   sudo screen -r
   
   #If server is stopped then manually start tng-bench-emusrv (on Machine 2)
   sudo screen -d -m tng-bench-emusrv
   
   # check output
   sudo screen -r
   ```

   

2. #### Clone repository 

   ```bash
   git clone https://github.com/arif332/tng-bench-experiments.git
   ```

3. #### Navigate to folder PED and other configuration file

   ```bash
   cd tng-bench-experiments
   ```

4. #### Run the experiments

   ```bash
   #activate python environments
   source /usr/local/src/venv/bin/activate
   
   #run experiment with ped file
   tng-bench -p experiments/peds/vaaa.yml --no-prometheus
   ```

   

5. #### Execution logs

   ```bash
   (venv) root@tng-bench-vm:/usr/local/src/tng-bench-experiments/experiments/peds# tng-bench -p vaaa.yml --no-prometheus
   2019-09-22 00:42:54 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Using config: /root/.tng-bench.conf
   2019-09-22 00:42:54 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO 5GTANGO benchmarking/profiling tool initialized
   2019-09-22 00:42:54 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Found old results: results
   Do you want to overwrite 'results'? (y/n/default: y)n
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Loaded PED file '/usr/local/src/tng-bench-experiments/experiments/peds/vaaa.yml'.
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.experiment[25388] INFO Populated experiment specification: 'vAAA1' with 1 configurations to be executed.
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[25388] INFO New 5GTANGO service configuration generator
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[25388] INFO Generating 1 service experiments using /usr/local/src/tng-bench-experiments/experiments/peds/../services/ns-1vnf-vAAA
   /usr/local/src/venv/lib/python3.6/site-packages/tngsdk/package/packager/packager.py:388: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
     data = yaml.load(f)
   /usr/local/src/venv/lib/python3.6/site-packages/tngsdk/package/packager/tango_packager.py:66: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
     data = yaml.load(f)
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[25388] INFO Generating 1 projects for Experiment(vAAA1)
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[25388] INFO Generated project (1/1): vAAA1_00000.tgo
   --------------------------------------------------------------------------------
   5GTANGO tng-bench: Experiment generation report
   --------------------------------------------------------------------------------
   Generated packages for 1 experiments with 1 configurations.
   Total time: 0.0879
   --------------------------------------------------------------------------------
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Initialized executor with 1 experiments and [1] configs
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Initialized VimEmuDriver with {'host': '192.168.151.61', 'emusrv_port': 4999, 'llcm_port': 5000, 'docker_port': 4998}
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Preparing target platforms
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Executing experiments
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Setting up 'ExperimentConfiguration(vAAA1_00000)'
   2019-09-22 00:42:59 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Waiting for emulator LLCM ... 0/60
   2019-09-22 00:43:00 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Waiting for emulator LLCM ... 1/60
   2019-09-22 00:43:01 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Waiting for emulator LLCM ... 2/60
   2019-09-22 00:43:02 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Waiting for emulator LLCM ... 3/60
   2019-09-22 00:43:11 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Emulator LLCM ready
   2019-09-22 00:43:11 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO On-boarding to LLCM: /tmp/tmpa29yppu7/gen_pkgs/vAAA1_00000.tgo
   2019-09-22 00:43:11 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[25388] INFO Instantiating NS: d6d7208d-8ab4-4c30-a7a1-9af0b3f81f83
   2019-09-22 00:43:14 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Instantiated service: cba875ca-095d-4a37-86fc-3fe854a516ce
   2019-09-22 00:43:14 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Executing 'ExperimentConfiguration(vAAA1_00000)'
   2019-09-22 00:43:14 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Warmup period (10s) ...
   2019-09-22 00:43:24 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Stimulating ...
   2019-09-22 00:44:27 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Collecting experiment results ...
   2019-09-22 00:44:27 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[25388] INFO Finalized 'ExperimentConfiguration(vAAA1_00000)'
   2019-09-22 00:44:27 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Teardown 'ExperimentConfiguration(vAAA1_00000)'
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.executor[25388] INFO Teardown target platforms
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Prepared 2 result processor(s)
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Running result processor '<tngsdk.benchmark.ietf.IetfBmwgVnfBD_Generator object at 0x7fa536539b00>'
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.ietf[25388] INFO IETF BMWG BD dir not specified (--ibbd). Skipping.
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Running result processor '<tngsdk.benchmark.resultprocessor.vimemu.VimemuResultProcessor object at 0x7fa52394afd0>'
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.resultprocessor.vimemu[25388] INFO Processing experiment metrics 1/1
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.resultprocessor.vimemu[25388] WARNING Couldn't process all container results: [Errno 2] No such file or directory: 'results/vAAA1_00000/mn.mp.input.vdu01.0/tngbench_share/result.yml'
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.resultprocessor.vimemu[25388] WARNING Couldn't process all container results: [Errno 2] No such file or directory: 'results/vAAA1_00000/mn.mp.output.vdu01.0/tngbench_share/result.yml'
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark.resultprocessor.vimemu[25388] WARNING Couldn't process all container results: [Errno 2] No such file or directory: 'results/vAAA1_00000/mn.vnf0.vdu01.0/tngbench_share/result.yml'
   <class 'pandas.core.frame.DataFrame'>
   RangeIndex: 1 entries, 0 to 0
   Data columns (total 37 columns):
   experiment_name                               1 non-null object
   experiment_start                              1 non-null object
   experiment_stop                               1 non-null object
   param__func__de.upb.vAAA.0.1__cmd_start       1 non-null object
   param__func__de.upb.vAAA.0.1__cmd_stop        1 non-null object
   param__func__de.upb.vAAA.0.1__cpu_bw          0 non-null object
   param__func__de.upb.vAAA.0.1__cpu_cores       1 non-null object
   param__func__de.upb.vAAA.0.1__io_bw           0 non-null object
   param__func__de.upb.vAAA.0.1__mem_max         1 non-null int64
   param__func__de.upb.vAAA.0.1__mem_swap_max    0 non-null object
   param__func__mp.input__cmd_start              1 non-null object
   param__func__mp.input__cmd_stop               1 non-null object
   param__func__mp.input__cpu_bw                 0 non-null object
   param__func__mp.input__cpu_cores              1 non-null object
   param__func__mp.input__io_bw                  0 non-null object
   param__func__mp.input__mem_max                0 non-null object
   param__func__mp.input__mem_swap_max           0 non-null object
   param__func__mp.output__cmd_start             1 non-null object
   param__func__mp.output__cmd_stop              1 non-null object
   param__func__mp.output__cpu_bw                0 non-null object
   param__func__mp.output__cpu_cores             1 non-null object
   param__func__mp.output__io_bw                 0 non-null object
   param__func__mp.output__mem_max               0 non-null object
   param__func__mp.output__mem_swap_max          0 non-null object
   param__header__all__config_id                 1 non-null int64
   param__header__all__repetition                1 non-null int64
   param__header__all__time_limit                1 non-null int64
   param__header__all__time_warmup               1 non-null int64
   param__mp__mp.input__address                  1 non-null object
   param__mp__mp.input__connection_point         1 non-null object
   param__mp__mp.input__container                1 non-null object
   param__mp__mp.input__name                     1 non-null object
   param__mp__mp.output__address                 1 non-null object
   param__mp__mp.output__connection_point        1 non-null object
   param__mp__mp.output__container               1 non-null object
   param__mp__mp.output__name                    1 non-null object
   run_id                                        1 non-null int64
   dtypes: int64(6), object(31)
   memory usage: 376.0+ bytes
   2019-09-22 00:44:31 tng-bench-vm tngbench.tngsdk.benchmark[25388] INFO Copying PED (/usr/local/src/tng-bench-experiments/experiments/peds/vaaa.yml) to folder results/original_ped.yml
   
   ```
