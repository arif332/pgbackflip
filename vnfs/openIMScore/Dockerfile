FROM ubuntu:18.04
LABEL maintainer="Arif Hossen <arif332@gmail.com>"

# define interface names (should be the same as in VNFD)
ENV IFIN input
ENV IFOUT output

#Install necessary software
RUN apt-get update && \
	apt-get install -y \
		bison \
		build-essential \ 
		curl \
		flex  \
		gcc-4.8 g++-4.8 \ 
		iproute2 \
		ipsec-tools \
		libcurl4-openssl-dev \
		libmysqld-dev \
		libxml2-dev \
		mysql-server \
		net-tools \
		software-properties-common \
		subversion \
		wget \
		&& rm -rf /var/lib/apt/lists/*

#setup gcc soft link
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 1000

#install java and ant process
#RUN cd /opt
WORKDIR /opt
RUN wget http://ftp.halifax.rwth-aachen.de/apache//ant/binaries/apache-ant-1.9.14-bin.tar.gz
RUN tar zxvf apache-ant-1.9.14-bin.tar.gz
ENV ANT_HOME="/opt/apache-ant-1.9.14"
ENV PATH=$PATH:$ANT_HOME/bin
ENV ANT_OPTS="-Dfile.encoding=utf-8"

#RUN cd /opt
WORKDIR /opt
COPY jdk-7u80-linux-x64.tar.gz /opt
COPY bash_export.sh /opt
RUN chmod +x bash_export.sh
RUN tar zxvf jdk-7u80-linux-x64.tar.gz
RUN rm -f jdk-7u80-linux-x64.tar.gz
ENV JAVA_HOME=/opt/jdk1.7.0_80
RUN update-alternatives --install /usr/bin/java java /opt/jdk1.7.0_80/bin/java 1500
RUN update-alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_80/bin/javac 1500
#RUN bash source bash_export.sh

#Copy ims source code and build
RUN mkdir -p /opt/OpenIMSCore/FHoSS
RUN mkdir -p /opt/OpenIMSCore/ser_ims
#RUN cd /opt/OpenIMSCore
WORKDIR /opt/OpenIMSCore
RUN svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS
RUN svn checkout https://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
#RUN cd /opt/OpenIMSCore/FHoSS
WORKDIR /opt/OpenIMSCore/FHoSS
RUN mv build.xml build.xml.orig
COPY build.xml build.xml
RUN ant compile deploy

#RUN cd /opt/OpenIMSCore/ser_ims
WORKDIR /opt/OpenIMSCore/ser_ims
RUN make install-libs all 

#import db configuration
WORKDIR /opt/OpenIMSCore
#RUN service mysql start
#CMD service mysql start && tail -F /var/log/mysql/error.log
#CMD /usr/bin/mysqld_safe
RUN service --status-all

RUN service mysql start && mysql -u root < FHoSS/scripts/hss_db.sql && mysql -u root < FHoSS/scripts/userdata.sql && mysql -u root < ser_ims/cfg/icscf.sql
#RUN mysql -u root < FHoSS/scripts/hss_db.sql
#RUN mysql -u root -p < FHoSS/scripts/userdata.sql
#RUN mysql -u root -p < ser_ims/cfg/icscf.sql

RUN cp ser_ims/cfg/*.cfg . 	
RUN cp ser_ims/cfg/*.xml .
RUN cp ser_ims/cfg/*.sh .

EXPOSE 3306 3869 3870 53 5060

#ADD start.sh start.sh
#RUN chmod +x start.sh
#ADD stop.sh stop.sh
#RUN chmod +x stop.sh

RUN mkdir /tngbench_share

#ENTRYPOINT
#CMD ["/usr/sbin/named"]
#CMD service mysql start && tail -F /var/log/mysql/error.log
COPY entrypoint-openims.sh entrypoint-openims.sh
RUN chmod +x entrypoint-openims.sh
CMD /opt/OpenIMSCore/entrypoint-openims.sh
