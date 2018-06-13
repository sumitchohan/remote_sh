rm -f out
mkfifo out
trap "rm -f out" EXIT
portFile=1501
while true
do
	echo "done" | nc.traditional -l -p $portFile -q 0 > file.dump
done