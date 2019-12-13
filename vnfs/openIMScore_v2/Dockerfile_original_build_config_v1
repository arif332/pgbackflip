FROM ubuntu:18.04
LABEL maintainer="Arif Hossen <earihos@mail.uni-paderborn.de> <arif332@gmail.com>"

# define interface names (should be the same as in VNFD)
ENV IFIN input
ENV IFOUT output

#Install necessary software
RUN apt-get update && \
	apt-get install -y \
		bind9 \
		bison \
		build-essential \ 
		curl \
		flex  \
		gcc-4.8 g++-4.8 \ 
		iproute2 \
		ipsec-tools \
		iputils-ping \
		libcurl4-openssl-dev \
		libmysqld-dev \
		libxml2-dev \
		mysql-server \
		net-tools \
		nginx \
		python \
		python-yaml \
		software-properties-common \
		subversion \
		tcpdump \
		tree \
		vim \
		wget \
		&& rm -rf /var/lib/apt/lists/*

#setup gcc soft link
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 1000

#install java and ant process
WORKDIR /opt
RUN wget http://ftp.halifax.rwth-aachen.de/apache//ant/binaries/apache-ant-1.9.14-bin.tar.gz
RUN tar zxvf apache-ant-1.9.14-bin.tar.gz
ENV ANT_HOME="/opt/apache-ant-1.9.14"
ENV PATH=$PATH:$ANT_HOME/bin
ENV ANT_OPTS="-Dfile.encoding=utf-8"

#Install JDK 1.7
WORKDIR /opt
COPY jdk-7u80-linux-x64.tar.gz /opt
COPY bash_export.sh /opt
RUN chmod +x bash_export.sh
RUN tar zxvf jdk-7u80-linux-x64.tar.gz
RUN rm -f jdk-7u80-linux-x64.tar.gz
ENV JAVA_HOME=/opt/jdk1.7.0_80
RUN update-alternatives --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 1500
RUN update-alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 1500


#Copy ims source code and build
RUN mkdir -p /opt/OpenIMSCore/FHoSS
RUN mkdir -p /opt/OpenIMSCore/ser_ims
WORKDIR /opt/OpenIMSCore
RUN svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS
RUN svn checkout https://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
WORKDIR /opt/OpenIMSCore/FHoSS
RUN mv build.xml build.xml.orig
COPY build.xml build.xml
RUN ant compile deploy

#compile ser package
WORKDIR /opt/OpenIMSCore/ser_ims
RUN make install-libs all 

#import db configuration
WORKDIR /opt/OpenIMSCore
RUN service mysql start && mysql -u root < FHoSS/scripts/hss_db.sql && mysql -u root < FHoSS/scripts/userdata.sql && mysql -u root < ser_ims/cfg/icscf.sql
#RUN mysql -u root -p < FHoSS/scripts/hss_db.sql
#RUN mysql -u root -p < FHoSS/scripts/userdata.sql
#RUN mysql -u root -p < ser_ims/cfg/icscf.sql

#copy config file
RUN cp ser_ims/cfg/*.cfg . 	
RUN cp ser_ims/cfg/*.xml .
RUN cp ser_ims/cfg/*.sh .
RUN cp /opt/OpenIMSCore/ser_ims/lib/*/*.so  /usr/local/lib/ser/
COPY ser_ims_cfg/scscf.cfg scscf.cfg
COPY ser_ims_cfg/icscf.cfg icscf.cfg
COPY ser_ims_cfg/pcscf.cfg pcscf.cfg


#DNS server Setup
WORKDIR /etc/bind
COPY conf/open-ims.dnszone open-ims.dnszone
RUN chown root:bind open-ims.dnszone

COPY conf/named.conf.default-zones named.conf.default-zones
RUN chown root:bind named.conf.default-zones

COPY conf/named.conf.options named.conf.options
RUN chown root:bind named.conf.options

COPY conf/resolv.conf /etc/resolv.conf.manual


#configure nginx to access tomcat webserver for hoss 
COPY hss-reverseproxy.conf /etc/nginx/sites-available
RUN rm -f /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/hss-reverseproxy.conf /etc/nginx/sites-enabled/hss-reverseproxy.conf

#install sip client
#RUN apt-get update && apt-get install -y git pkg-config dh-autoreconf ncurses-dev build-essential libssl-dev libpcap-dev libncurses5-dev libsctp-dev lksctp-tools
#WORKDIR /usr/local/src
#RUN git clone https://github.com/SIPp/sipp.git
#WORKDIR /usr/local/src/sipp
#RUN ./build.sh --with-pcap --with-sctp --with-openssl
#RUN cp sipp /usr/local/bin/
#RUN mkdir /ims-test-conf
#WORKDIR /ims-test-conf
#COPY ims-test-conf /ims-test-conf


EXPOSE 53 80 3306 3868 3869 3870 4060/tcp 5060 6060 8080 4060/udp
#EXPOSE 53 80 3306 3868 3869 3870 4060 5060 6060 8080



RUN mkdir /tngbench_share

#ENTRYPOINT
WORKDIR /opt/OpenIMSCore
COPY entrypoint-openims.sh entrypoint-openims.sh
RUN chmod +x entrypoint-openims.sh

#startup script for the 
WORKDIR /
ADD start.sh start.sh
RUN chmod +x start.sh
ADD stop.sh stop.sh
RUN chmod +x stop.sh
ADD log_intf_statistics.py log_intf_statistics.py


ENTRYPOINT ["/opt/OpenIMSCore/entrypoint-openims.sh"]
CMD [""]

