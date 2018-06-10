#172e1f84
##set
#curl -X POST https://api.keyvalue.xyz/172e1f84/myKey/ON
#curl -X POST https://api.keyvalue.xyz/b3290c28/myKey/ON
##get
#curl https://api.keyvalue.xyz/172e1f84/myKey
#awk '{ sub("\r$", ""); print }' run.sh > run1.sh

oldSwitch="#@%^&!^"
retryDelay=30
error="y"
while [ 1 -le 2 ]
do
	switch=$(curl https://api.keyvalue.xyz/b3290c28/myKey -k -s)
	echo "switch - $switch"
	if [ "$switch" = "$oldSwitch" ]
	then
		echo "No Change"
	else
		if [ "$switch" = "ON" ]
		then
			# input tap 615 462
			adb shell "input tap 600 10"
			sleep $retryDelay
			sleep $retryDelay
			adb shell "input tap 600 10"
		fi
		echo $switch
		oldSwitch=$switch
	fi
	adb shell "input tap 300 265"
	dt=$(date '+%Y-%m-%dT%H:%M:%S');
	curl -d "OFF-$dt" -X POST https://api.keyvalue.xyz/b3290c28/myKey -k -s
	sleep $retryDelay
done
