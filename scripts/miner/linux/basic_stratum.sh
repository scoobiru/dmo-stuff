#!/bin/bash

#Param, fill in <> with chosen values
mode=stratum
host=<host>
port=<port>
address=<wallet>
worker=<worker>

minerbin=dyn_miner2
diff=<2...n>
#Password value may need adjustment depending on specific pool, please consult pool op for details
password=d=$diff
device=GPU
compute=<1024...n>
workitems=<32,64,128,256,512>
platform=<0...n>
card=<0...n>
#Optional loops param
loops=<2-10>

#Choose param depending on use of loops
params="-mode $mode -server $host -port $port -user $address.$worker -pass $password -miner $device,$compute,$workitems,$platform,$card"
#params="-mode $mode -server $host -port $port -user $address.$worker -pass $password -miner $device,$compute,$workitems,$platform,$card,$loops"

echo Starting $minerbin $mode on $device at $host to $address
echo Params: $params
./$minerbin $params

exit