FROM amazonlinux:latest
COPY . /tmp/
RUN chmod 755 /tmp/scripts/hardening.sh
RUN chmod 755 /tmp/scripts/hardening2.sh
RUN /tmp/scripts/hardening.sh
RUN /tmp/scripts/hardening2.sh
WORKDIR /tmp
ADD https://downloads.cisofy.com/lynis/lynis-3.0.8.tar.gz /tmp
RUN yum install tar -y
RUN tar xfvz /tmp/lynis-3.0.8.tar.gz 
RUN cd /tmp/lynis &&  ./lynis audit system
