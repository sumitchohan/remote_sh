counter=1
while [ "$counter" -le 10000 ] 
do
	echo "counter - $counter"
	adb shell "cd sdcard/coc && source do.sh && Run 1"
	adb shell "cd sdcard/coc && source do.sh && Run 2"
	sleep 2100
	counter=$((counter+1))
done

