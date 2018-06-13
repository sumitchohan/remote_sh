portFile=1501
while true
do
	nc.traditional -l -p $portFile -q 0 >  file.dump
done