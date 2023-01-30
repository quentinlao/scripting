#!/bin/bash

# run ./zenchef.sh 356608 2023-03-01 2023-03-28
# restaurantId : 356608 Shinko 
#  
restaurantId=$1
date_begin=$2
date_end=$3
if [ $# -eq 0 ]
  then
    echo "Enter zenchef restaurantId:"
    read -n 1 restaurantId
    echo "Enter zenchef date_begin:"
    read -n 1 date_begin
    echo "Enter zenchef date_end:"
    read -n 1 date_end
fi

# GET curl api zenchef
# 356608 2023-02-01 2023-02-28
response=$(curl -s -H "Content-Type: application/json" -H 'Accept: application/json' -X GET "https://bookings-middleware.zenchef.com/getAvailabilitiesSummary?restaurantId=$restaurantId&date_begin=$date_begin&date_end=$date_end")

# arrays dates
dates=()

while read -r line; do
  # possible_guests at least "2"
  if echo $line | grep -q '"possible_guests.*2.*'; then
    # Récupération de la date associée à l'objet
    date=$(echo $line | grep -o '"date":"[^"]*"')
    date=${date#*:\"}
    date=${date%\"*}

    # add to tabs
    dates+=($date)
  fi
done <<< "$(echo $response | tr '}' '\n')"

# echo "Date available : ${dates[@]}"

mondays=()

for date in "${dates[@]}"; do
  # Convert date to timestamp
  timestamp=$(date -d "$date" +%s)
  
  # (0 sunday, 1 monday, ...)
  day_of_week=$(date -d "@$timestamp" +%u)
  
  # add to mondays if mmonday
  if [ "$day_of_week" == "1" ]; then
    mondays+=("$date")
  fi
done

if [ ${#mondays[@]} -eq 0 ]; then
    exit 0
else
    echo "restaurantId : $restaurantId"
    echo "date_begin : $date_begin"
    echo "date_end : $date_end"
    echo "Pour lundi : ${mondays[@]}"
fi

# show result

# foreach result with cron 30min notif with sendmail to user to book a place 
# create a file crontab -e 

#  */30 * * * * /absolute/path/zenchef.sh 356608 2023-03-01 2023-03-28  | sendmail -t sample@example.com
#  sample : */30 * * * * /mnt/e/github/scripting/zenchef/zenchef.sh  | sendmail -t sample@example.com