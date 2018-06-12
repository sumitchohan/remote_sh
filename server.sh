rm -f out
mkfifo out
trap "rm -f out" EXIT
port=1500
while true
do
	cat out | nc -l $port > >( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
    while read line
    do
		# echo " request line  - $line"
		crlf=$'\n'
		line=$(echo "$line" | tr -d '[\r\n]')
		if [ "x$line" = x ] # empty line / end of request
		then 
			sh handler.sh $REQUEST > out 
		else 
			REQUEST="$REQUEST$crlf$line"
		fi
    done
  )
done