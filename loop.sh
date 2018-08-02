counter=1
while [ "$counter" -le 10000 ] 
do
	echo "$counter.."
	adb shell "cd sdcard/coc && source do.sh && Run"
	sleep 1800
	counter=$((counter+1))
done

