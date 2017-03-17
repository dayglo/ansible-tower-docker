# Ansible Tower Dockerfie

FROM ubuntu:16.04

MAINTAINER george@automationlogic.com

ENV TOWER_VERSION=3.1.1
ENV PACKAGENAME=ansible-tower-setup-${TOWER_VERSION}

# Install tower

RUN apt-get update && \
	apt-get install -y software-properties-common sudo iproute2
RUN apt-add-repository ppa:ansible/ansible

ADD https://releases.ansible.com/ansible-tower/setup/${PACKAGENAME}.tar.gz /tmp/towersetup/

RUN cd /tmp/towersetup \
	&& tar -xvf ${PACKAGENAME}.tar.gz 

ADD inventory /tmp/towersetup/${PACKAGENAME}/

RUN locale-gen en_US
RUN locale-gen en_US.UTF-8

RUN cd /tmp/towersetup/${PACKAGENAME} \
	&& ./setup.sh

# Our stuff

COPY start.sh /
RUN chmod +x ./start.sh

RUN mkdir -p /certs

# VOLUME ${PG_DATA}
VOLUME /certs

VOLUME /etc/tower/license

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 443 80

CMD ["/start.sh"]