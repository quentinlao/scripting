#!/bin/bash
word=$(cat $2 | head -$3 | tail -1 | tr '[a-z]' '[A-Z]')
wLength=$(echo -n $word | wc -c)
uScore=""
for((i=0; i<$wLength; i++))
do
    uScore+="_"
done
echo "Mystery word:" $uScore "("$wLength" letters)"
echo "Enter a letter:"
read -n 1 c
#if [  "$c" != '' ]
#then
    #echo "salut"
#else

c=$(echo $c | tr '[a-z]' '[A-Z]')
#printf "\n"
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
if [ $found -eq 1 ]
then
    echo $c "found!"
    echo "Mystery word: "$newAns "("$wLength "letters)"
    echo "Good job, you are ready for the next step!"
else
    echo $c "not found!"
    echo "Mystery word: "$newAns "("$wLength "letters)"
    echo "Better luck next time!"
fi
#else
#    uScore=""
#    for((i=0; i<$wLength; i++))
#    do
#    uScore+="_"
#    done
#    echo $c "not found:!"
#    echo "Mystery word: "$uScore "("$wLength "letters)"
#   echo "Better luck next time!"
    
#fi
