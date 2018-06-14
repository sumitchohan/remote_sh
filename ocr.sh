oldIFS=$IFS
IFS=","
while read line
do
	parts=($(echo "$line" | tr ',' '\n')) 
	echo "${parts[0]}"
	echo "${parts[1]}"	
done < "$1.config"
IFS=$oldIFS 