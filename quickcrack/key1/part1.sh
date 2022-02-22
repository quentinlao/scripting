#!/bin/bash

###############################################
# Test each number to arg1 
###############################################

# seq to format; -f format print;  2 digit; %0 zeropadded from left; g no decimal
for i in $(seq -f "%02g" 0 $1)
do
     echo $i
    
done

