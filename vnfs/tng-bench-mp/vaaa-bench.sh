#! /bin/bash

vvv_server=20.0.0.254
rsecret=testing123

echo "start radclient for testing"

radclient  -c 5000000 -n 1000000 -p 1000000 -s -q -f testuserdb $vvv_server:1812 auth $rsecret

echo "end radclient testing"
