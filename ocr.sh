while read line
do
	parts=($(echo "$line" | tr ',' '\n'))
	echo "convert '/tmp/scr.png[${parts[3]}x${parts[4]}+${parts[1]}+${parts[2]}]' /tmp/${parts[0]}.png" | sh
	echo "./ocrutil/OcrUtil KeepPixels /tmp/${parts[0]}.png /tmp/${parts[0]}_C.png ./ocrutil/whitelist.txt" | sh 
	#echo "convert -resize 200% /tmp/${parts[0]}_C.png /tmp/${parts[0]}_C1.png" | sh 
	echo "tesseract /tmp/${parts[0]}_C.png /tmp/${parts[0]}_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1" | sh
	cat "/tmp/${parts[0]}_C.txt" | sed 's/[^0-9]*//g' > /tmp/${parts[0]}.txt
	cat  /tmp/${parts[0]}.txt
	adb push /tmp/${parts[0]}.txt /sdcard/coc/${parts[0]}.txt
done < "$1.config"
