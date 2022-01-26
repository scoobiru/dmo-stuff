#!/bin/bash

#Param, fill in <> with chosen values
mode=solo
host=http://<node_rpcaddress>:<node_rpcport>/
user=<node_rpcuser>
pass=<node_rpcpassword
address=<wallet>

minerbin=dyn_miner2
device=GPU
compute=<1024...n>
workitems=<32,64,128,256,512>
platform=<0...n>
card=<0...n>
#Optional loops param
loops=<2-10>

#Choose param depending on use of loops
params="-mode $mode -server $host -user $user -pass $pass -wallet $address -miner $device,$compute,$workitems,$platform,$card"
#params="-mode $mode -server $host -user $user -pass $pass -wallet $address -miner $device,$compute,$workitems,$platform,$card,$loops"

echo Starting $minerbin $mode on $device at $host to $address
echo Params: $params
./$minerbin $params

exit