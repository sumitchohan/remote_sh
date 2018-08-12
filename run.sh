#172e1f84
##set
#curl -X POST https://api.keyvalue.xyz/172e1f84/myKey/ON
#curl -X POST https://api.keyvalue.xyz/b3290c28/myKey/ON
##get
#curl https://api.keyvalue.xyz/172e1f84/myKey
#awk '{ sub("\r$", ""); print }' run.sh > run1.sh

Exec()
{
	adb shell "cd sdcard/coc && source do.sh && Run 1"
	adb shell "cd sdcard/coc && source do.sh && Run 2"
}
 
error="y"
waitCount=60
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
			Exec
			waitCounter=$waitCount
		fi
	elif [ "$switch" = "STOPPED" ]
	then
		waitCounter=$waitCount
		echo "Stopped. Doing Nothing"
		sleep $heartBeatDelay
	elif [ "$switch" = "START" ]
	then
		Exec
		curl -d "ON" -X POST https://api.keyvalue.xyz/b3290c28/myKey -k -s
		waitCounter=$waitCount
	else
		sleep $heartBeatDelay
	fi
done
