
convert '/tmp/scr.png[55x20+67+81]' /tmp/Trophy.png
./ocrutil/OcrUtil KeepPixels /tmp/Trophy.png /tmp/Trophy_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Trophy_C.png /tmp/Trophy_C1.png
tesseract /tmp/Trophy_C1.png /tmp/Trophy_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Trophy_C.txt" | sed 's/[^0-9]*//g' > /tmp/Trophy.txt
adb push /tmp/Trophy.txt /sdcard/coc/ocred_Trophy.txt
convert '/tmp/scr.png[126x21+622+22]' /tmp/Gold.png
./ocrutil/OcrUtil KeepPixels /tmp/Gold.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gold_C.png /tmp/Gold_C1.png
tesseract /tmp/Gold_C1.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold.txt
adb push /tmp/Gold.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[88x21+661+70]' /tmp/Elixir.png
./ocrutil/OcrUtil KeepPixels /tmp/Elixir.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Elixir_C.png /tmp/Elixir_C1.png
tesseract /tmp/Elixir_C1.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir.txt
adb push /tmp/Elixir.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[83x20+668+121]' /tmp/DE.png
./ocrutil/OcrUtil KeepPixels /tmp/DE.png /tmp/DE_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/DE_C.png /tmp/DE_C1.png
tesseract /tmp/DE_C1.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE.txt
adb push /tmp/DE.txt /sdcard/coc/ocred_DE.txt
convert '/tmp/scr.png[56x21+689+168]' /tmp/Gems.png
./ocrutil/OcrUtil KeepPixels /tmp/Gems.png /tmp/Gems_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gems_C.png /tmp/Gems_C1.png
tesseract /tmp/Gems_C1.png /tmp/Gems_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gems_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gems.txt
adb push /tmp/Gems.txt /sdcard/coc/ocred_Gems.txt
convert '/tmp/scr.png[54x20+287+20]' /tmp/Builders.png
./ocrutil/OcrUtil KeepPixels /tmp/Builders.png /tmp/Builders_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Builders_C.png /tmp/Builders_C1.png
tesseract /tmp/Builders_C1.png /tmp/Builders_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Builders_C.txt" | sed 's/[^0-9]*//g' > /tmp/Builders.txt
adb push /tmp/Builders.txt /sdcard/coc/ocred_Builders.txt
