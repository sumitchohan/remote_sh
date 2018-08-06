result="n"
if  [ "$elixir" -ge "550000" ] || [ "$eg" -ge "1100000" ]
then
	if [ "$isth10" = "y" ]
	then	
        result="y"
	fi
fi 
if  [ "$elixir" -ge "800000" ] || [ "$eg" -ge "1600000" ]
then 
    result="y"
fi 
echo $result