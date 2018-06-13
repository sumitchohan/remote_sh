 
portFile=1501
while true
do
	echo "done" | nc.traditional -l -p $portFile -q 0 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
	rm file.dump
    export REQUEST=
    while read line
    do
		line >> file.dump
    done
  )
done