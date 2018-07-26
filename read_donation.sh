echo "time - $(date +%S_%N)"
adb shell screencap /sdcard/scr.raw
adb pull /sdcard/coc/donationRequest.config /tmp/donationRequest.config
echo "time - $(date +%S_%N)"
adb pull /sdcard/scr.raw
echo "time - $(date +%S_%N)"
tail -c +13 scr.raw > scr.rgba
hexdump -e '/4 "%d"' -s 0 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 4 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 8 -n 4 scr.raw
convert -size 800x666 -depth 8 scr.rgba /tmp/scr.png
echo "time - $(date +%S_%N)"
while read line
do
	parts=($(echo "$line" | tr ',' '\n'))
	echo "convert '/tmp/scr.png[${parts[3]}x${parts[4]}+${parts[1]}+${parts[2]}]' /tmp/${parts[0]}.png" | sh
	#echo "./ocrutil/OcrUtil KeepPixels /tmp/${parts[0]}.png /tmp/${parts[0]}_C.png ./ocrutil/whitelist.txt" | sh 
	#echo "convert -resize 200% /tmp/${parts[0]}_C.png /tmp/${parts[0]}_C1.png" | sh 
	echo "tesseract /tmp/${parts[0]}.png /tmp/${parts[0]}_C" | sh
	cat "/tmp/${parts[0]}_C.txt" | sed 's/[^0-9]*//g' > /tmp/${parts[0]}.txt
	res=$(cat  "/tmp/${parts[0]}.txt")
	echo "${parts[0]} - $res"
	adb push /tmp/${parts[0]}.txt /sdcard/coc/${parts[0]}.txt
done < "/tmp/donationRequest.config"

