counter=1
while [ "$counter" -le 100000 ] 
do
	echo "counter - $counter"
	adb shell "cd sdcard/coc && source do.sh && Run 1"
	adb shell "cd sdcard/coc && source do.sh && Run 2"
	sleep 1500
	counter=$((counter+1))
done

