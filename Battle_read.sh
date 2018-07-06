dt=$(date '+%Y-%m-%dT%H_%M_%S')
convert '/tmp/scr.png[70x18+46+68]' '/tmp/Gold_1.png'
convert /tmp/Gold_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/Gold_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Gold_2.png /tmp/Gold_C.png ./ocrutil/whitelist.txt
convert -resize 200% '/tmp/Gold_C.png' '/tmp/Gold_C1.png'
tesseract /tmp/Gold_C1.png /tmp/Gold_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Gold_C.txt" | sed 's/[^0-9]*//g' > /tmp/Gold_$dt.txt
adb push /tmp/Gold_$dt.txt /sdcard/coc/ocred_Gold.txt
convert '/tmp/scr.png[82x21+42+95]' '/tmp/Elixir_1.png'
convert /tmp/Elixir_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/Elixir_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Elixir_2.png /tmp/Elixir_C.png ./ocrutil/whitelist.txt
convert -resize 200% '/tmp/Elixir_C.png' '/tmp/Elixir_C1.png'
tesseract /tmp/Elixir_C1.png /tmp/Elixir_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Elixir_C.txt" | sed 's/[^0-9]*//g' > /tmp/Elixir_$dt.txt
adb push /tmp/Elixir_$dt.txt /sdcard/coc/ocred_Elixir.txt
convert '/tmp/scr.png[83x21+43+123]' '/tmp/DE_1.png'
convert /tmp/DE_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/DE_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/DE_2.png /tmp/DE_C.png ./ocrutil/whitelist.txt
convert -resize 200% '/tmp/DE_C.png' '/tmp/DE_C1.png'
tesseract /tmp/DE_C1.png /tmp/DE_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/DE_C.txt" | sed 's/[^0-9]*//g' > /tmp/DE_$dt.txt
adb push /tmp/DE_$dt.txt /sdcard/coc/ocred_DE.txt
convert '/tmp/scr.png[48x24+47+164]' '/tmp/Win_1.png'
convert /tmp/Win_1.png -fuzz 300 -fill white -opaque "#FFE8FD" '/tmp/Win_2.png'
./ocrutil/OcrUtil KeepPixels /tmp/Win_2.png /tmp/Win_C.png ./ocrutil/whitelist.txt
convert -resize 200% '/tmp/Win_C.png' '/tmp/Win_C1.png'
tesseract /tmp/Win_C1.png /tmp/Win_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Win_C.txt" | sed 's/[^0-9]*//g' > /tmp/Win_$dt.txt
adb push /tmp/Win_$dt.txt /sdcard/coc/ocred_Win.txt
