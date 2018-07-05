dt=$(date '+%Y-%m-%dT%H_%M_%S');
convert '/tmp/scr.png[55x20+67+81]' /tmp/Trophy_$dt_1.png
convert /tmp/Trophy_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/Trophy_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Trophy_$dt.png /tmp/Trophy_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Trophy_C.png /tmp/Trophy_C1.png
tesseract /tmp/Trophy_C1.png /tmp/Trophy_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Trophy_C.txt" | sed 's/[^0-9]*//g' > /tmp/Trophy_$dt.txt
adb push /tmp/Trophy_$dt.txt /sdcard/coc/ocred_Trophy.txt
convert '/tmp/scr.png[126x21+622+22]' /tmp/Gold_$dt_1.png
convert /tmp/Gold_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/Gold_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Gold_$dt.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gold_C.png /tmp/Gold_C1.png
tesseract /tmp/Gold_C1.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold_$dt.txt
adb push /tmp/Gold_$dt.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[88x21+661+70]' /tmp/Elixir_$dt_1.png
convert /tmp/Elixir_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/Elixir_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Elixir_$dt.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Elixir_C.png /tmp/Elixir_C1.png
tesseract /tmp/Elixir_C1.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir_$dt.txt
adb push /tmp/Elixir_$dt.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[83x20+668+121]' /tmp/DE_$dt_1.png
convert /tmp/DE_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/DE_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/DE_$dt.png /tmp/DE_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/DE_C.png /tmp/DE_C1.png
tesseract /tmp/DE_C1.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE_$dt.txt
adb push /tmp/DE_$dt.txt /sdcard/coc/ocred_DE.txt
convert '/tmp/scr.png[56x21+689+168]' /tmp/Gems_$dt_1.png
convert /tmp/Gems_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/Gems_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Gems_$dt.png /tmp/Gems_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gems_C.png /tmp/Gems_C1.png
tesseract /tmp/Gems_C1.png /tmp/Gems_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gems_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gems_$dt.txt
adb push /tmp/Gems_$dt.txt /sdcard/coc/ocred_Gems.txt
convert '/tmp/scr.png[54x20+287+20]' /tmp/Builders_$dt_1.png
convert /tmp/Builders_$dt_1.png -fuzz 300 -fill white -opaque #FFE8FD /tmp/Builders_$dt.png
./ocrutil/OcrUtil KeepPixels /tmp/Builders_$dt.png /tmp/Builders_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Builders_C.png /tmp/Builders_C1.png
tesseract /tmp/Builders_C1.png /tmp/Builders_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Builders_C.txt" | sed 's/[^0-9]*//g' > /tmp/Builders_$dt.txt
adb push /tmp/Builders_$dt.txt /sdcard/coc/ocred_Builders.txt
