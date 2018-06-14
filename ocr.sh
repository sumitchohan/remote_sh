Read()
{
while read line
do
	parts=($(echo "$line" | tr ',' '\n')) 
	echo "convert '/tmp/scr.png[${parts[3]}x${parts[4]}+${parts[2]}+${parts[1]}]' /tmp/${parts[0]}.png" 
done < "$1.config" 
}