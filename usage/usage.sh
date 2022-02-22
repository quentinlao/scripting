#!/bin/bash
strErr='[Usage]: ./usage.sh --source file.txt number'
if [ "$#" -eq 3 ]
then
    if [ "$1" = "--source"  ]
    then
	if [ -f $2  ]
	then
	    countL=$(cat $2 | wc -l)
	    countL=$(echo $countL + 1 | bc -l)
	    if [[ $3 -gt 0 && $3 -lt $countL ]]
	    then
		echo "No error, ready for the next step!"
	    else
		printf "[Error]: your argument '"$3"' is invalid!\n"
		echo '[Error]: it must be a number between 1 and the max number of lines in '$2'!'
		echo $strErr
	    fi
	    
	else
	    echo '[Error]: '$2' is not a file!'
	    echo $strErr
	fi
	
    else
	echo '[Error]: first argument must be --source!'
	echo $strErr
    fi
    
else
    echo '[Error]: there should be exactly 3 arguments!'
    echo $strErr
fi
   
