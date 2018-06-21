#!/bin/bash
rm -f out
mkfifo out
trap "rm -f out" EXIT
port=8901
while true
do
	cat out | nc.traditional -l -p $port -q 0 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
	#this will not work correctly for multi line requests
    export REQUEST=
    while read line
    do
		echo " request line  - $line"
		bash handler.sh $line > out  
    done 
  )
done