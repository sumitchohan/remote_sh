#echo "$0" "$#" "$1" "$2" "$3" "$4" "$5"
#ls
if [ -f "$1" ]
then
	sh $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
else
	echo "$* not found."
fi
#echo "<EOF>"
