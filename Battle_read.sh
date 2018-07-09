dt=$(date '+%Y-%m-%dT%H_%M_%S')
convert '/tmp/scr.png[76x19+48+68]' '/tmp/Gold_1.png'
convert /tmp/Gold_1.png -fuzz 300 -fill white -opaque "#FFFBCC" '/tmp/Gold_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Gold_2.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
#convert -resize 200% '/tmp/Gold_C.png' '/tmp/Gold_C.png'
tesseract /tmp/Gold_C.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold_$dt.txt
adb push /tmp/Gold_$dt.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[83x20+45+96]' '/tmp/Elixir_1.png'
convert /tmp/Elixir_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/Elixir_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Elixir_2.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
#convert -resize 200% '/tmp/Elixir_C.png' '/tmp/Elixir_C.png'
tesseract /tmp/Elixir_C.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir_$dt.txt
adb push /tmp/Elixir_$dt.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[69x17+45+125]' '/tmp/DE_1.png'
convert /tmp/DE_1.png -fuzz 300 -fill white -opaque "#F3F3F3" '/tmp/DE_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/DE_2.png /tmp/DE_C.png ./ocrutil/whitelist.txt
#convert -resize 200% '/tmp/DE_C.png' '/tmp/DE_C.png'
tesseract /tmp/DE_C.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE_$dt.txt
adb push /tmp/DE_$dt.txt /sdcard/coc/ocred_DE.txt
convert '/tmp/scr.png[38x19+47+168]' '/tmp/Win_1.png'
convert /tmp/Win_1.png -fuzz 300 -fill white -opaque "#FFFFFF" '/tmp/Win_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Win_2.png /tmp/Win_C.png ./ocrutil/whitelist.txt
#convert -resize 200% '/tmp/Win_C.png' '/tmp/Win_C.png'
tesseract /tmp/Win_C.png /tmp/Win_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Win_C.txt" | sed 's/[^0-9]*//g' > /tmp/Win_$dt.txt
adb push /tmp/Win_$dt.txt /sdcard/coc/ocred_Win.txt
convert '/tmp/scr.png[43x18+51+213]' '/tmp/Loose_1.png'
convert /tmp/Loose_1.png -fuzz 300 -fill white -opaque "#FFBFBF" '/tmp/Loose_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Loose_2.png /tmp/Loose_C.png ./ocrutil/whitelist.txt
#convert -resize 200% '/tmp/Loose_C.png' '/tmp/Loose_C.png'
tesseract /tmp/Loose_C.png /tmp/Loose_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Loose_C.txt" | sed 's/[^0-9]*//g' > /tmp/Loose_$dt.txt
adb push /tmp/Loose_$dt.txt /sdcard/coc/ocred_Loose.txt
cp /tmp/scr.png ~/Desktop/gh/remote_sh/cv/
echo "" > /tmp/troopMap.txt
th9=$(curl http://localhost:8952/findObject/th9/scr.png -s) 
th10=$(curl http://localhost:8952/findObject/th10/scr.png -s) 
th11=$(curl http://localhost:8952/findObject/th11/scr.png -s)  
echo "th9 - $th9 ; th10 - $th10 ; th11 - $th11 " > /tmp/ocred_Th.txt
adb push /tmp/ocred_Th.txt /sdcard/coc/ocred_Th.txt
