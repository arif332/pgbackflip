#
# PG BackFlip Project work
#

FROM freeradius/freeradius-server:latest
LABEL maintainer="earihos@mail.paderborn.de/arif332@gmail.com"

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
	python-yaml \
	vim \
	curl \
	&& rm -rf /var/lib/apt/lists/*


COPY raddb/ /etc/raddb/
COPY status /etc/raddb/sites-enabled/status
#EXPOSE 1812/udp 1813/udp
EXPOSE 1812 1813

WORKDIR /
RUN mkdir /tngbench_share

ADD start.sh start.sh
RUN chmod +x start.sh
ADD stop.sh stop.sh
RUN chmod +x stop.sh
ADD log_intf_statistics.py log_intf_statistics.py
ADD radius_stat_processor.sh radius_stat_processor.sh
RUN chmod +x radius_stat_processor.sh


#start free radius server
#ENTRYPOINT
#CMD ["/usr/sbin/named"]
