dt=$(date '+%Y-%m-%dT%H_%M_%S');
convert '/tmp/scr.png[131x34+217+328]' /tmp/Troops_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Troops_$dt.png /tmp/Troops_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Troops_C.png /tmp/Troops_C1.png
tesseract /tmp/Troops_C1.png /tmp/Troops_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troops_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troops_$dt.txt
adb push /tmp/Troops_$dt.txt /sdcard/coc/ocred_Troops.txt
convert '/tmp/scr.png[82x32+201+577]' /tmp/Spells_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Spells_$dt.png /tmp/Spells_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Spells_C.png /tmp/Spells_C1.png
tesseract /tmp/Spells_C1.png /tmp/Spells_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Spells_C.txt" | sed 's/[^0-9]*//g' > /tmp/Spells_$dt.txt
adb push /tmp/Spells_$dt.txt /sdcard/coc/ocred_Spells.txt
convert '/tmp/scr.png[141x28+915+330]' /tmp/Time_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Time_$dt.png /tmp/Time_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Time_C.png /tmp/Time_C1.png
tesseract /tmp/Time_C1.png /tmp/Time_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Time_C.txt" | sed 's/[^0-9]*//g' > /tmp/Time_$dt.txt
adb push /tmp/Time_$dt.txt /sdcard/coc/ocred_Time.txt
