rm -f out
mkfifo out
trap "rm -f out" EXIT
portFile=1501
while true
do
	cat out | nc.traditional -l -p $portFile -q 0 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
    while read line
    do
		echo " request line  - $line"
		crlf=$'\n' 
		sh handler.sh $line > out  
    done
  )
done