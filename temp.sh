key=""
username=$(hostname)
if [ "$username" = "sumit-Latitude-E6440" ]
then
	key="b3290c28"
else if [ "$username" = "Sumits-MacBook-Pro.local" ]
	then
		key="c93c2e48"
	fi
fi
echo "$key"
