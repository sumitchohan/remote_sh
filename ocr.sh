oldIFS=$IFS
IFS=","
while read line
do
	echo $line
	set -A parts $line
	echo "${parts[0]}"
	echo "${parts[1]}"
	
done < "$1.config"
IFS=$oldIFS 