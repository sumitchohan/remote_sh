while read line
do
	parts=($(echo "$line" | tr ',' '\n')) 
	echo "convert 'scr.png[${parts[3]}x${parts[4]}+${parts[2]}+${parts[1]}]' ${parts[0]}.png" | sh
done < "$1.config" 