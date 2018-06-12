echo "$0" "$#" "$1" "$2" "$3" "$4" "$5"
ls
if [ -f "$3" ]
then
	sh $3 $4 $5 $6 $7 $8 $9 $10
else
	echo "$3 not found."
fi
echo "<EOF>"
