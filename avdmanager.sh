threads=$(wmctrl -lx | grep Nexus5XNew | tr ' ' '\n' | grep 0x)
while read line; do
	echo "closing - $line"
	wmctrl -ic $line
	sleep 10
done < <(echo $threads)
~/Android/Sdk/emulator/emulator -avd $1
