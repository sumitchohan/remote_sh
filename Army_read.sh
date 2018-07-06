dt=$(date '+%Y-%m-%dT%H_%M_%S')
convert '/tmp/scr.png[86x20+109+135]' '/tmp/Troops_1.png'
convert /tmp/Troops_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/Troops_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Troops_2.png /tmp/Troops_C.png ./ocrutil/whitelist.txt
convert -resize 200% '/tmp/Troops_C.png' '/tmp/Troops_C1.png'
tesseract /tmp/Troops_C1.png /tmp/Troops_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troops_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troops_$dt.txt
adb push /tmp/Troops_$dt.txt /sdcard/coc/ocred_Troops.txt
