# tng-bench-experiments


## Document History

```
Author: Arif
Document History:
2019-09-21	V1	run vAAA in vim-emu environment
2019-11-05	V1	Added OpenIMSCore experiment information
```



## Introduction

Method of Procedure for vnf experiment  in between tng-bench & vim-emu environment -



## Lab setup for the experiments

```bash

tng-bench			<----------------------->			vim-emu server
192.168.151.60											192.168.151.61
```





## Check VIM-EMU Server 

Check server process in vim-emu server -

```bash
#login to vim-emu server and check whether server is running or not
sudo screen -r

#If server is stopped then manually start tng-bench-emusrv (on Machine 2)
sudo screen -d -m tng-bench-emusrv

# check output
sudo screen -r
```



## vAAA experiment

Clone repository in tng-bench client -

```bash
#login to tng-bench server and clone git repository 
git clone https://github.com/arif332/tng-bench-experiments.git
```

Navigate for PED and other configuration file

```bash
cd tng-bench-experiments
ls experiments/peds
ls experiments/services
```

Initiate experiments in tng-bench client -

```bash
#activate python environments
source /usr/local/src/venv/bin/activate

#run experiment with ped file
tng-bench -p experiments/peds/vaaa.yml --no-prometheus
```



## OpenIMSCore experiment

Clone repository in tng-bench client -

```bash
git clone https://github.com/arif332/tng-bench-experiments.git
```

Navigate for PED and other configuration files for OpenIMSCore -

```bash
cd tng-bench-experiments
ls experiments/peds
ls experiments/services
```

Initiate experiments in tng-bench client -

```bash
#activate python environments
source /usr/local/src/venv/bin/activate

#run experiment with ped file
tng-bench -p experiments/peds/openimscore.yml --no-prometheus
```







## Appendix:

Config.yml in tng-bench

```bash
---
targets:
  - name: default
    description: "vim-emu execution platform on local lab"
    pdriver: vimemu  # type of target (vimemu, osm)
    pdriver_config:  # structure can be pdriver specific
      host: 192.168.151.61
      emusrv_port: 4999
      llcm_port: 5000
      docker_port: 4998

```



#### Execution logs for OpenIMSCore

```bash
(venv) root@tng-bench-vm:/usr/local/src/tng-bench-experiments# tng-bench -p experiments/peds/openimscore.yml --no-prometheus
2019-11-05 00:35:49 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Using config: /root/.tng-bench.conf
2019-11-05 00:35:49 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO 5GTANGO benchmarking/profiling tool initialized
2019-11-05 00:35:49 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Found old results: results
Do you want to overwrite 'results'? (y/n/default: y)y
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Overwriting old results: results
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Loaded PED file '/usr/local/src/tng-bench-experiments/experiments/peds/openimscore.yml'.
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.experiment[23235] INFO Populated experiment specification: 'openimscore' with 1 configurations to be executed.
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[23235] INFO New 5GTANGO service configuration generator
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[23235] INFO Generating 1 service experiments using /usr/local/src/tng-bench-experiments/experiments/peds/../services/ns-1vnf-openimscore
/usr/local/src/venv/lib/python3.6/site-packages/tngsdk/package/packager/packager.py:388: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
  data = yaml.load(f)
/usr/local/src/venv/lib/python3.6/site-packages/tngsdk/package/packager/tango_packager.py:66: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
  data = yaml.load(f)
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[23235] INFO Generating 1 projects for Experiment(openimscore)
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.generator.tango[23235] INFO Generated project (1/1): openimscore_00000.tgo
--------------------------------------------------------------------------------
5GTANGO tng-bench: Experiment generation report
--------------------------------------------------------------------------------
Generated packages for 1 experiments with 1 configurations.
Total time: 0.1091
--------------------------------------------------------------------------------
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Initialized executor with 1 experiments and [1] configs
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Initialized VimEmuDriver with {'host': '192.168.151.61', 'emusrv_port': 4999, 'llcm_port': 5000, 'docker_port': 4998}
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Preparing target platforms
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Executing experiments
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Setting up 'ExperimentConfiguration(openimscore_00000)'
2019-11-05 00:35:51 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Waiting for emulator LLCM ... 0/60
2019-11-05 00:35:52 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Waiting for emulator LLCM ... 1/60
2019-11-05 00:35:53 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Waiting for emulator LLCM ... 2/60
2019-11-05 00:35:54 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Waiting for emulator LLCM ... 3/60
2019-11-05 00:36:04 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Emulator LLCM ready
2019-11-05 00:36:04 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO On-boarding to LLCM: /tmp/tmpco90bt9h/gen_pkgs/openimscore_00000.tgo
2019-11-05 00:36:33 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu.emuc[23235] INFO Instantiating NS: c42d422c-7415-4515-a066-12f0dda690c0
2019-11-05 00:36:35 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Instantiated service: 9533854f-62b6-4386-955d-89c137ab207e
2019-11-05 00:36:35 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Executing 'ExperimentConfiguration(openimscore_00000)'
2019-11-05 00:36:36 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Warmup period (10s) ...
2019-11-05 00:36:46 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Stimulating ...
2019-11-05 00:37:53 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Collecting experiment results ...
2019-11-05 00:37:53 tng-bench-vm tngbench.tngsdk.benchmark.pdriver.vimemu[23235] INFO Finalized 'ExperimentConfiguration(openimscore_00000)'
2019-11-05 00:37:53 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Teardown 'ExperimentConfiguration(openimscore_00000)'
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark.executor[23235] INFO Teardown target platforms
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Prepared 2 result processor(s)
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Running result processor '<tngsdk.benchmark.ietf.IetfBmwgVnfBD_Generator object at 0x7fbe41d7fba8>'
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark.ietf[23235] INFO IETF BMWG BD dir not specified (--ibbd). Skipping.
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Running result processor '<tngsdk.benchmark.resultprocessor.vimemu.VimemuResultProcessor object at 0x7fbe431132e8>'
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark.resultprocessor.vimemu[23235] INFO Processing experiment metrics 1/1
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 1 entries, 0 to 0
Columns: 301 entries, experiment_name to run_id
dtypes: float64(264), int64(6), object(31)
memory usage: 2.4+ KB
2019-11-05 00:37:56 tng-bench-vm tngbench.tngsdk.benchmark[23235] INFO Copying PED (/usr/local/src/tng-bench-experiments/experiments/peds/openimscore.yml) to folder results/original_ped.yml
(venv) root@tng-bench-vm:/usr/local/src/tng-bench-experiments#
```