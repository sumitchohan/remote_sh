while read line
do
	parts=($(echo "$line" | tr ',' '\n')) 
	convert 'scr.png[${parts[3]}x${parts[4]}+${parts[2]}+${parts[1]}]' ${parts[0]}.png
done < "$1.config" 