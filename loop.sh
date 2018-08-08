counter=1
while [ "$counter" -le 10000 ] 
do
	echo "counter - $counter"
	source avdmanager.sh Nexus5XNew1
	sleep 15
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	sleep 5
	sh init.sh
	source start.sh	
	adb shell "cd sdcard/coc && source do.sh && Run 1"
	
	source avdmanager.sh Nexus5XNew2
	sleep 15
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	sleep 5
	sh init.sh
	source start.sh	
	adb shell "cd sdcard/coc && source do.sh && Run 2"
	sleep 2000
	counter=$((counter+1))
done

