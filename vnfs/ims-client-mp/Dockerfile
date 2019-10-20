FROM ubuntu:latest
LABEL maintainer="arif332@gmail.com"

RUN	apt-get update && apt-get install -y \
		software-properties-common \
		autoconf \
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
		pkg-config \
		dh-autoreconf \
		ncurses-dev \
		libssl-dev \
		libpcap-dev \
		libncurses5-dev \
		libsctp-dev \
		lksctp-tools
		



WORKDIR /usr/local/src
RUN git clone https://github.com/SIPp/sipp.git
WORKDIR /usr/local/src/sipp
RUN ./build.sh --with-pcap --with-sctp --with-openssl
RUN cp sipp /usr/local/bin/
RUN mkdir /ims-test-conf
WORKDIR /ims-test-conf
#COPY non_em_reg_alice.xml non_em_reg_alice.xml
COPY ims-test-conf /ims-test-conf

#EXPOSE 3050-3070
EXPOSE 3061/tcp 3061/udp


WORKDIR /
ADD start.sh start.sh
RUN chmod +x start.sh

ADD stop.sh stop.sh
RUN chmod +x stop.sh

ADD ims-client-reg.sh ims-client-reg.sh
RUN chmod +x ims-client-reg.sh

WORKDIR /ims-test-conf
RUN mkdir /tngbench_share
CMD /bin/bash

