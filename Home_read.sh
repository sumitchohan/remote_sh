dt=$(date '+%Y-%m-%dT%H_%M_%S');
convert '/tmp/scr.png[85x30+109+139]' /tmp/Trophy_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Trophy_$dt.png /tmp/Trophy_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Trophy_C.png /tmp/Trophy_C1.png
tesseract /tmp/Trophy_C1.png /tmp/Trophy_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Trophy_C.txt" | sed 's/[^0-9]*//g' > /tmp/Trophy_$dt.txt
adb push /tmp/Trophy_$dt.txt /sdcard/coc/ocred_Trophy.txt
convert '/tmp/scr.png[181x35+1327+35]' /tmp/Gold_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Gold_$dt.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gold_C.png /tmp/Gold_C1.png
tesseract /tmp/Gold_C1.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold_$dt.txt
adb push /tmp/Gold_$dt.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[175x32+1336+122]' /tmp/Elixir_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Elixir_$dt.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Elixir_C.png /tmp/Elixir_C1.png
tesseract /tmp/Elixir_C1.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir_$dt.txt
adb push /tmp/Elixir_$dt.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[145x29+1367+206]' /tmp/DE_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/DE_$dt.png /tmp/DE_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/DE_C.png /tmp/DE_C1.png
tesseract /tmp/DE_C1.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE_$dt.txt
adb push /tmp/DE_$dt.txt /sdcard/coc/ocred_DE.txt
