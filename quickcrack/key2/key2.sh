#!/bin/bash
cd ..
cd out/www
pwd
bina=$(cat 3w99eho0oM) 
bina=".*****...*.***....*.****.*****....**..**..**.***..**.*....**...*"
bina=$(echo -n $bina | tr -c '.' '1' | tr -c '1' '0' )
echo $bina

#hex=$(printf '%x\n' "$((2#$bina))") 
#echo $hex
