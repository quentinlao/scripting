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



################################
		#echo "No error, ready for the next step!"


rPath=$(pwd)

    cd ..
    cd choose_word
    word=$(./choose_word.sh $1 $rPath/$2 $3)
    valPrev=""

    state=10
    cd ..
    cd user_input
    previous=""
 
    wLength=$(echo -n $word | wc -c)
    uScore=""
    for((i=0; i<$wLength; i++))
    do
	    uScore+="_"
    done
    echo "Mystery word:" $uScore "("$wLength" letters, 10 tries left)"
    while [ "$state" -ne 0 ]
    do
       	
	echo "Enter a letter or a word:"
	read c
	c=$(echo $c | tr '[a-z]' '[A-Z]')

	if [ "${#c}" -ne 1 ]
	then
	    if [ "$c" = "$word" ]
	    then
		echo $word "was the mystery word! You win!"
		state=0
	    else
		echo $c "is not the mystery word!"
		state=$((state - 2))
		if [ "$state" = 0 ]
		then
		    echo "No more tries! You lose!"
		    echo "The mystery word was: "$word"..."
		else
		    echo "Previous letters propositions were: "$valPrev
		    echo "Mystery word: "$uScore" ("$wLength "letters, "$state" tries left)"
		fi
	        
	        
	    fi

	else
	
	found=0
	newAns=""
	
	for i in $(seq 1 $wLength)
	do
	    step=$(echo "${word:i-1:1}")
	    stepAns=$(echo "${uScore:i-1:1}")
    
	    if [ $step == $c ]
	    then
		found=1
		newAns+=$c
	    elif [ $stepAns == "_" ]
	    then
		newAns+="_"
	    else
		newAns+=$stepAns
	    fi
    
	 
	done
	uScore=$newAns
	already=0


	for((i=0;i<${#previous};i++))
 	do
	    step=$(echo "${previous: $i:1}")
    
	    if [ "$step" = "$c" ]
	    then
		already=1
	 
	    fi
        done

	if [ "$already" = 1  ]
	then    
	    state=$(( state + 1 ))
	
	else
	    previous+=$c
	fi
	if [[ "$found" = 1 && "$already" = 0 ]]
	then    
	    state=$(( state + 1 ))
	fi

	
	pLength=$(echo -n $previous | wc -c)
	pLength=$((pLength - 1))


	
    
	valPrev=$(echo $previous | sed 's/./& /g')
	if [ "$newAns" = "$word" ]
	then
	    echo $c "found!"
	    echo $word "was the mystery word! You win!"
	    state=1
	
	

	elif [ $found -eq 1 ]
	then
	    
	    echo $c "found!"
	    echo "Previous letters propositions were: "$valPrev
	    echo "Mystery word: "$newAns "("$wLength "letters, "$((state - 1))" tries left)"
	    #echo "Good job, you are ready for the next step!"
	else
	    echo $c "not found!"
	    if [ "$state" -eq 1 ]
	    then
		echo "No more tries! You lose!"
		echo "The mystery word was: "$word"..."
	    else
		
	    echo "Previous letters propositions were: "$valPrev
	    echo "Mystery word: "$newAns "("$wLength "letters, "$((state - 1))" tries left)"
	    fi
	    #echo "Better luck next time!"
	fi
	
	state=$((state - 1))

	fi
    done

    
    




################################
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
   













