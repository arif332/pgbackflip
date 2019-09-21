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
		curl


ADD start.sh start.sh
RUN chmod +x start.sh

ADD stop.sh stop.sh
RUN chmod +x stop.sh

WORKDIR /
RUN mkdir /tngbench_share
CMD /bin/bash

