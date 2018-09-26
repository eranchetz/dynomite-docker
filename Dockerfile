FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install telnet -y
RUN apt-get install redis-server -y
RUN apt-get install -y autoconf build-essential dh-autoreconf	git libssl-dev libtool -y
RUN git clone https://github.com/Netflix/dynomite.git

WORKDIR dynomite/


RUN autoreconf -fvi 
RUN ./configure --enable-debug=yes
RUN  make

EXPOSE 8102

COPY configuration-file.yaml conf/
COPY startup.sh startup.sh

# Setting overcommit for Redis to be able to do BGSAVE/BGREWRITEAOF
#RUN sysctl vm.overcommit_memory=1

# Set the entry-point to be the startup script
ENTRYPOINT ["./startup.sh"]
