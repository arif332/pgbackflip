FROM freeradius/freeradius-server:latest


# define interface names (should be the same as in VNFD)
ENV IFIN input
ENV IFOUT output


RUN apt-get update && \
	apt-get install -y \
	net-tools \
	git \
	iproute2 \
	iputils-ping \
	nano \
    	python-dev \
        python-pip \
	vim \
	curl \
	&& rm -rf /var/lib/apt/lists/*


COPY raddb/ /etc/raddb/
#EXPOSE 1812/udp 1813/udp
EXPOSE 1812 1813

WORKDIR /
ADD start.sh start.sh
RUN chmod +x start.sh
ADD stop.sh stop.sh
RUN chmod +x stop.sh
ADD log_intf_statistics.py log_intf_statistics.py


RUN mkdir /tngbench_share
#start free radius server
#ENTRYPOINT
#CMD ["/usr/sbin/named"]
