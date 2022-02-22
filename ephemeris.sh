#!/bin/bash
TODAY=$(date +"%A %B %d, %Y.")


json=$(curl -s -H "Content-Type: application/json" -H 'Accept: application/json' -X POST "https://api.sunrise-sunset.org/json?lat=48.813875&lng=2.392521&date=today")
sr=$(echo $json | grep -o '"sunrise":"[^"]*')    
sr=$(echo $sr | cut -d '"' -f4)

ss=$(echo $json | grep -o '"sunset":"[^"]*')
ss=$(echo $ss | cut -d '"' -f4)
  
iss=$(curl -s -H "Content-Type: application/json" -H 'Accept: application/json' -i -X GET "http://aletum.jails.simplerezo.com/etna-iss.json")



lt=$(echo $iss | grep -o '"latitude": "[^"]*')    
#echo $lt
lt=$(echo $lt | cut -d '"' -f4)

lg=$(echo $iss | grep -o '"longitude": "[^"]*')
lg=$(echo $lg | cut -d '"' -f4)

lat1=48.813875
lon1=2.392521
lat2=$lt
lon2=$lg
PI=3.14159265358
eathRadiusKm=6371
dLat=$(echo "($lat2-$lat1)*$PI/180" | bc -l)
dLon=$(echo "($lon2-$lon1)*$PI/180" | bc -l)
l1=$(echo "($lat1)*$PI/180" | bc -l)
l2=$(echo "($lat2)*$PI/180" | bc -l)
a=$(echo "(s($dLat/2) * s($dLat/2) + s($dLon/2) * s($dLon/2)* c($l1)* c($l2))" | bc -l)
atann=$((echo $a  | awk '{print atan2(sqrt($a),sqrt(1 -$a))}') | bc -l)
result=$(echo "2 * $atann * $eathRadiusKm" | bc -l)
#echo "$dLat $dLon $l1 $l2 $atann $a"
result=$(echo ${result%.*}  )

echo "Today we are $TODAY"
echo "Sunrise is expected at $sr and sunset at $ss."
echo "The ISS is currently located at $lt, $lg: $result""km from us!"