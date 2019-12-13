FROM ubuntu:latest
LABEL maintainer="arif332@gmail.com"

RUN	apt-get update && apt-get install -y \
		software-properties-common \
		autoconf \
		aptitude \
		cmake \
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
		python-pip \
		siege \
		httperf \
    		gettext \
		curl \
		pkg-config \
		dh-autoreconf \
		ncurses-dev \ 
		libgsl-dev \
		libssl-dev \
		libpcap-dev \
		libncurses5-dev \
		libsctp-dev \
		lksctp-tools
		

RUN pip install pandas

WORKDIR /usr/local/src
#RUN git clone https://github.com/SIPp/sipp.git
RUN git clone https://github.com/arif332/sipp.git

WORKDIR /usr/local/src/sipp
#RUN ./build.sh --with-pcap --with-sctp --with-openssl
#RUN ./configure
#RUN ./	make
RUN cmake . -DUSE_SSL=1 -DUSE_SCTP=1 -DUSE_PCAP=1 -DUSE_GSL=1 -DBUILD_STATIC=1
RUN make
RUN cp sipp /usr/local/bin/
RUN mkdir /ims-test-conf
WORKDIR /ims-test-conf
#COPY non_em_reg_alice.xml non_em_reg_alice.xml
COPY ims-test-conf /ims-test-conf

#EXPOSE 3050-3070
EXPOSE 3060-3065/tcp 3060-3065/udp


WORKDIR /
#ADD start.sh start.sh
#RUN chmod +x start.sh
#ADD stop.sh stop.sh
#RUN chmod +x stop.sh

ADD mp_input_start.sh mp_input_start.sh
RUN chmod +x mp_input_start.sh
ADD mp_output_start.sh mp_output_start.sh
RUN chmod +x mp_output_start.sh
ADD stop.sh stop.sh
RUN chmod +x stop.sh
ADD log_intf_statistics.py log_intf_statistics.py
ADD python_stat_processor.py python_stat_processor.py
ADD stat_processor.sh stat_processor.sh
RUN chmod +x stat_processor.sh

ADD ims-client-reg.sh ims-client-reg.sh
RUN chmod +x ims-client-reg.sh

#WORKDIR /ims-test-conf
RUN mkdir /tngbench_share
WORKDIR /
CMD /bin/bash

