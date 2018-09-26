#172e1f84
##set
#curl -X POST https://api.keyvalue.xyz/172e1f84/myKey/ON
#curl -X POST https://api.keyvalue.xyz/b3290c28/myKey/ON
##get
#curl https://api.keyvalue.xyz/172e1f84/myKey
#awk '{ sub("\r$", ""); print }' run.sh > run1.sh

export DISPLAY=:0
Exec()
{
	adb shell "echo 'hi'"
	adb shell "echo 'hi'"
	adb push do.sh /sdcard/coc/
	adb push scr.conf /sdcard/coc/
	source start.sh
	adb shell "cd /sdcard/coc && source do.sh && Run $1" 
}
Avd_Start()
{
	~/Android/Sdk/emulator/emulator -avd $1 &
}
Avd_Close()
{
	threads=$(wmctrl -lx | grep AVD | tr ' ' '\n' | grep 0x)
	while read line; do
		echo "closing - $line"
		wmctrl -ic $line
		sleep 10
		echo "Closed - $line"
	done < <(echo $threads)
}
error="y"
waitCount=40
waitCounter=$waitCount
heartBeatDelay=30
while [ 1 -le 2 ]
do
	switch=$(curl https://api.keyvalue.xyz/b3290c28/myKey -k -s)
	echo "switch - $switch"
	if [ "$switch" = "ON" ]
	then
		echo "On"
		if [ "$waitCounter" -ge 0 ]
		then
			echo "waitCounter - $waitCounter"
			waitCounter=$((waitCounter-1))
			sleep $heartBeatDelay
		else 			
			Avd_Close
			sleep 5
			Avd_Start AVD1
			sleep 20
			Exec "1"	
			Avd_Close
			sleep 5
			Avd_Start AVD2
			sleep 20
			Exec "2"
			waitCounter=$waitCount
		fi
	elif [ "$switch" = "STOPPED" ]
	then
		waitCounter=$waitCount
		echo "Stopped. Doing Nothing"
		sleep $heartBeatDelay
	elif [ "$switch" = "START" ]
	then
		curl -d "ON" -X POST https://api.keyvalue.xyz/b3290c28/myKey -k -s
		Exec
		waitCounter=$waitCount
	else
		sleep $heartBeatDelay
	fi
done
