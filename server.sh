rm -f out
mkfifo out
trap "rm -f out" EXIT
port=1500
while true
do
	cat out | nc.traditional -l -p $port -q 0 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
    while read line
    do
		echo " request line  - $line"
		crlf=$'\n' 
		REQUEST="$REQUEST$crlf$line"
    done 
	sh handler.sh $REQUEST > out  
  )
done