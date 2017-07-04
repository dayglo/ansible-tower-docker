#!/bin/bash

if [ ! -f /certs/ansible ]; then
	echo no ansible cert found - this must be a fresh deployment.
	echo generating cert....
	ssh-keygen -f /certs/ansible -t rsa -N ''
fi

if cat ~/.ssh/config | grep 'Host node*'
then
    echo ssh config already set up.
else
    echo adding ssh config.
	echo "Host node* 
	    HostName %h 
	    IdentityFile /certs/ansible
	    StrictHostKeyChecking no" >> ~/.ssh/config
fi


/usr/bin/ansible-tower-service start 

tail -f \
/var/log/postgresql/postgresql-9.4-main.log \
/var/log/nginx/access.log \
/var/log/nginx/error.log \
/var/log/tower/tower_rbac_migrations.log \
/var/log/tower/fact_receiver.log \
/var/log/tower/tower_system_tracking_migrations.log \
/var/log/tower/callback_receiver.log \
/var/log/tower/task_system.log \
/var/log/tower/tower.log \
/var/log/memcached.log \
/var/log/supervisor/supervisord.log \
/var/log/supervisor/awx-uwsgi.log \
/var/log/supervisor/awx-daphne.log \
/var/log/supervisor/awx-celeryd.log \
/var/log/supervisor/awx-channels-worker.log \
/var/log/supervisor/awx-celeryd-beat.log \
/var/log/supervisor/awx-fact-cache-receiver.log \
/var/log/supervisor/awx-callback-receiver.log \
/var/log/supervisor/failure-event-handler.stderr.log \
| 
    awk '/^==> / {a=substr($0, 5, length-8); next}
                 {print a":"$0}'