#!/bin/bash
#get script path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null
 	
echo $SCRIPTPATH

docker run -d \
	-P \
	--name tower \
	-v "$SCRIPTPATH/license.txt":/etc/tower/license \
	-v tower_certs:/certs \
	-v tower_db:/var/lib/postgresql \
	-e TOWER_INIT_SCM_URL=https://github.com/dayglo/synergy-poc-setup \
	ansible-tower:3.1.1

docker logs -f tower