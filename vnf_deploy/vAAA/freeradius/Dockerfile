FROM freeradius/freeradius-server:latest
RUN apt-get update

RUN apt-get install net-tools git iproute2 iputils-ping nano vim -y

COPY raddb/ /etc/raddb/
#EXPOSE 1812/udp 1813/udp
EXPOSE 1812 1813
