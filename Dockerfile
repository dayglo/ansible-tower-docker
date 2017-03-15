# Ansible Tower Dockerfie

FROM ubuntu:16.04

MAINTAINER george@automationlogic.com

ENV TOWER_VERSION=3.1.1
ENV PACKAGENAME=ansible-tower-setup-${TOWER_VERSION}

RUN apt-get update && \
	apt-get install -y software-properties-common sudo iproute2
RUN apt-add-repository ppa:ansible/ansible

ADD https://releases.ansible.com/ansible-tower/setup/${PACKAGENAME}.tar.gz /tmp/towersetup/

RUN cd /tmp/towersetup \
	&& tar -xvf ${PACKAGENAME}.tar.gz 

# had to edit this file - all i did was to remove 'sudo ' from line 317 and 319, might sed it instead...
#ADD setup.sh /tmp/towersetup/${PACKAGENAME}/
ADD inventory /tmp/towersetup/${PACKAGENAME}/

RUN locale-gen en_US
RUN locale-gen en_US.UTF-8

# RUN ip r

RUN cd /tmp/towersetup/${PACKAGENAME} \
	&& ./setup.sh



# ENV ANSIBLE_TOWER_VER=latest
# ENV PG_DATA=/var/lib/postgresql/9.4/main

# ADD http://releases.ansible.com/awx/setup/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz /opt/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz

# RUN cd /opt && tar -xvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
#     && rm -rf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
#     && mv ansible-tower-setup-${ANSIBLE_TOWER_VER} /opt/tower-setup \
#     && sed -i 's/10000000000/1000000000/g' /opt/tower-setup/roles/preflight/defaults/main.yml

# ADD tower_setup_conf.yml /opt/tower-setup/tower_setup_conf.yml
# ADD inventory /opt/tower-setup/inventory

# RUN cd /opt/tower-setup \
#     && ./setup.sh

# ADD task_engine.py /usr/lib/python2.7/dist-packages/awx/main/task_engine.py
# VOLUME ${PG_DATA}
# VOLUME /certs

# ADD docker-entrypoint.sh /docker-entrypoint.sh

# RUN chmod +x /docker-entrypoint.sh

EXPOSE 443 8080

CMD ["ansible-tower"]