#!/bin/bash

card=0
cards=6
minerparam="-miner GPU,0,0,0,$card"
while [ $card -le $cards ]
do
minerparam="$minerparam -miner GPU,0,0,0,$card"
let "card++"
done
echo $minerparam

params="-mode $mode -server $host -user $user -pass $pass -wallet $address $minerparam"
echo ""
echo $params

exit
