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
cp /tmp/scr.png ~/Desktop/gh/remote_sh/cv/
echo "" > /tmp/troopMap.txt
#th9=$(curl http://localhost:8952/findObject/th9/scr.png -s) 
th10="n"#$(curl http://localhost:8952/findObject/th10/scr.png -s) 
#th11=$(curl http://localhost:8952/findObject/th11/scr.png -s)  
echo $th10 > /tmp/ocred_Th10.txt
#echo $th9 > /tmp/ocred_Th9.txt
adb push /tmp/ocred_Th10.txt /sdcard/coc/ocred_Th10.txt
