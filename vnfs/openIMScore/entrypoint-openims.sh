#!/usr/bin/env bash
set -e

echo "127.0.0.1 open-ims.test mobicents.open-ims.test ue.open-ims.test presence.open-ims.test icscf.open-ims.test scscf.open-ims.test
pcscf.open- ims.test hss.open-ims.test" >> /etc/hosts
 
#fhoss service
service mysql start
/opt/OpenIMSCore/fhoss.sh &

/opt/OpenIMSCore/scscf.sh &

/opt/OpenIMSCore/pcscf.sh &

/opt/OpenIMSCore/icscf.sh &


/bin/bash

