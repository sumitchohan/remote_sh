echo "dt=\$(date '+%Y-%m-%dT%H_%M_%S');" >$1_read.sh
while read line
do
	parts=($(echo "$line" | tr ',' '\n'))
	echo "convert '/tmp/scr.png[${parts[3]}x${parts[4]}+${parts[1]}+${parts[2]}]' /tmp/${parts[0]}_\$dt.png" >>$1_read.sh
	echo "./ocrutil/OcrUtil KeepPixels /tmp/${parts[0]}_\$dt.png /tmp/${parts[0]}_C.png ./ocrutil/whitelist.txt" >>$1_read.sh
	echo "convert -resize 200% /tmp/${parts[0]}_C.png /tmp/${parts[0]}_C1.png" >>$1_read.sh 
	echo "tesseract /tmp/${parts[0]}_C1.png /tmp/${parts[0]}_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1" >>$1_read.sh
	echo "cat \"/tmp/${parts[0]}_C.txt\" | sed 's/[^0-9]*//g' > /tmp/${parts[0]}_\$dt.txt" >>$1_read.sh 
	echo "adb push /tmp/${parts[0]}_\$dt.txt /sdcard/coc/ocred_${parts[0]}.txt" >>$1_read.sh
done < "$1.config"
