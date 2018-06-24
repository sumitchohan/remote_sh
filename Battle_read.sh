
convert '/tmp/scr.png[70x18+46+68]' /tmp/Gold.png
./ocrutil/OcrUtil KeepPixels /tmp/Gold.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Gold_C.png /tmp/Gold_C1.png
tesseract /tmp/Gold_C1.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold.txt
adb push /tmp/Gold.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[82x21+42+95]' /tmp/Elixir.png
./ocrutil/OcrUtil KeepPixels /tmp/Elixir.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Elixir_C.png /tmp/Elixir_C1.png
tesseract /tmp/Elixir_C1.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir.txt
adb push /tmp/Elixir.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[83x21+43+123]' /tmp/DE.png
./ocrutil/OcrUtil KeepPixels /tmp/DE.png /tmp/DE_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/DE_C.png /tmp/DE_C1.png
tesseract /tmp/DE_C1.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE.txt
adb push /tmp/DE.txt /sdcard/coc/ocred_DE.txt
convert '/tmp/scr.png[48x24+47+164]' /tmp/Win.png
./ocrutil/OcrUtil KeepPixels /tmp/Win.png /tmp/Win_C.png ./ocrutil/whitelist.txt
convert -resize 200% /tmp/Win_C.png /tmp/Win_C1.png
tesseract /tmp/Win_C1.png /tmp/Win_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Win_C.txt" | sed 's/[^0-9]*//g' > /tmp/Win.txt
adb push /tmp/Win.txt /sdcard/coc/ocred_Win.txt
