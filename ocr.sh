while read line
do
	parts=($(echo "$line" | tr ',' '\n'))
	echo "convert '/tmp/scr.png[${parts[3]}x${parts[4]}+${parts[1]}+${parts[2]}]' /tmp/${parts[0]}.png" | sh
	echo "tesseract /tmp/${parts[0]}.png -o ${parts[0]}" | sh
done < "$1.config"
