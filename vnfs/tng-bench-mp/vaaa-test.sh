
#ping 20.0.0.254
#ping 20.0.0.1
vvv_server=20.0.0.254
rsecret=testing123


radtest bob test $vvv_server 0 $rsecret
radtest bob test2 $vvv_server 0 $rsecret
radtest baduser test2 $vvv_server 0 $rsecret
radtest rob rob1 $vvv_server 0 $rsecret
radtest fb fb1 $vvv_server 0 $rsecret
radtest david david1 $vvv_server 0 $rsecret

