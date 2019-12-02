FROM ubuntu:latest
LABEL maintainer="earihos@mail.paderborn.de"

RUN	apt-get update && apt-get install -y \
		software-properties-common \
		aptitude \
    		git \
    		wget \
    		build-essential \
    		python-dev \
        	python-pip \
		net-tools \
		iproute2 \
		inetutils-ping \
		curl \
		iperf3 \
		iperf \
		tcpreplay \
		bmon \
		nmap \
		python \
		python-yaml \
		siege \
		httperf \
    		gettext \
		curl \
		freeradius-utils


WORKDIR /
RUN mkdir /tngbench_share

ADD start.sh start.sh
RUN chmod +x start.sh

ADD stop.sh stop.sh
RUN chmod +x stop.sh

ADD log_intf_statistics.py log_intf_statistics.py
ADD radius_stat_processor.sh radius_stat_processor.sh
RUN chmod +x radius_stat_processor.sh

ADD vaaa-test.sh vaaa-test.sh
RUN chmod +x vaaa-test.sh
ADD vaaa-bench.sh vaaa-bench.sh
RUN chmod +x vaaa-bench.sh

ADD testuserdb testuserdb
ADD smalldb smalldb



CMD /bin/bash

