dt=$(date '+%Y-%m-%dT%H_%M_%S');
adb shell "screencap -p /sdcard/cap_$dt.png"
adb pull /sdcard/cap_$dt.png ~/Desktop/Shared/cap_$dt.png
cp ~/Desktop/Shared/cap_$dt.png ~/Desktop/Shared/cap_latest.png