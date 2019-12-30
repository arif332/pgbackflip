#! /bin/bash

vvv_server=20.0.0.254
rsecret=testing123

echo "`data` : starting radclient for testing"
radclient  -c 1000 -n 1000 -p 1000 -s -q -f smalldb $vvv_server:1812 auth $rsecret
echo "`date` : starting radclient big testing"
radclient  -c 10000000 -n 1000000 -p 1000000 -s -q -f testuserdb $vvv_server:1812 auth $rsecret

echo "`date` : end radclient testing"
