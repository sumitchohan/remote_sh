
convert '/tmp/scr.png[34x19+111+136]' /tmp/Trained.png
./ocrutil/OcrUtil KeepPixels /tmp/Trained.png /tmp/Trained_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Trained_C.png /tmp/Trained_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Trained_C.txt" | sed 's/[^0-9]*//g' > /tmp/Trained.txt
adb push /tmp/Trained.txt /sdcard/coc/Trained.txt
convert '/tmp/scr.png[36x19+154+135]' /tmp/Total.png
./ocrutil/OcrUtil KeepPixels /tmp/Total.png /tmp/Total_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Total_C.png /tmp/Total_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Total_C.txt" | sed 's/[^0-9]*//g' > /tmp/Total.txt
adb push /tmp/Total.txt /sdcard/coc/Total.txt
convert '/tmp/scr.png[79x18+111+136]' /tmp/Full.png
./ocrutil/OcrUtil KeepPixels /tmp/Full.png /tmp/Full_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Full_C.png /tmp/Full_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Full_C.txt" | sed 's/[^0-9]*//g' > /tmp/Full.txt
adb push /tmp/Full.txt /sdcard/coc/Full.txt
convert '/tmp/scr.png[15x14+31+234]' /tmp/Troop1Level.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop1Level.png /tmp/Troop1Level_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop1Level_C.png /tmp/Troop1Level_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop1Level_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop1Level.txt
adb push /tmp/Troop1Level.txt /sdcard/coc/Troop1Level.txt
convert '/tmp/scr.png[14x15+105+233]' /tmp/Troop2Level.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop2Level.png /tmp/Troop2Level_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop2Level_C.png /tmp/Troop2Level_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop2Level_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop2Level.txt
adb push /tmp/Troop2Level.txt /sdcard/coc/Troop2Level.txt
convert '/tmp/scr.png[15x14+178+234]' /tmp/Troop3Level.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop3Level.png /tmp/Troop3Level_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop3Level_C.png /tmp/Troop3Level_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop3Level_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop3Level.txt
adb push /tmp/Troop3Level.txt /sdcard/coc/Troop3Level.txt
convert '/tmp/scr.png[50x17+36+166]' /tmp/Troop1Count.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop1Count.png /tmp/Troop1Count_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop1Count_C.png /tmp/Troop1Count_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop1Count_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop1Count.txt
adb push /tmp/Troop1Count.txt /sdcard/coc/Troop1Count.txt
convert '/tmp/scr.png[48x18+108+166]' /tmp/Troop2Count.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop2Count.png /tmp/Troop2Count_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop2Count_C.png /tmp/Troop2Count_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop2Count_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop2Count.txt
adb push /tmp/Troop2Count.txt /sdcard/coc/Troop2Count.txt
convert '/tmp/scr.png[48x16+181+167]' /tmp/Troop3Count.png
./ocrutil/OcrUtil KeepPixels /tmp/Troop3Count.png /tmp/Troop3Count_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Troop3Count_C.png /tmp/Troop3Count_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Troop3Count_C.txt" | sed 's/[^0-9]*//g' > /tmp/Troop3Count.txt
adb push /tmp/Troop3Count.txt /sdcard/coc/Troop3Count.txt
convert '/tmp/scr.png[18x19+97+280]' /tmp/Spells1Left.png
./ocrutil/OcrUtil KeepPixels /tmp/Spells1Left.png /tmp/Spells1Left_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Spells1Left_C.png /tmp/Spells1Left_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Spells1Left_C.txt" | sed 's/[^0-9]*//g' > /tmp/Spells1Left.txt
adb push /tmp/Spells1Left.txt /sdcard/coc/Spells1Left.txt
convert '/tmp/scr.png[18x17+123+281]' /tmp/Spells1Right.png
./ocrutil/OcrUtil KeepPixels /tmp/Spells1Right.png /tmp/Spells1Right_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Spells1Right_C.png /tmp/Spells1Right_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Spells1Right_C.txt" | sed 's/[^0-9]*//g' > /tmp/Spells1Right.txt
adb push /tmp/Spells1Right.txt /sdcard/coc/Spells1Right.txt
convert '/tmp/scr.png[43x18+99+281]' /tmp/Spells1Full.png
./ocrutil/OcrUtil KeepPixels /tmp/Spells1Full.png /tmp/Spells1Full_C.png ./ocrutil/whitelist.txt
tesseract /tmp/Spells1Full_C.png /tmp/Spells1Full_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/Spells1Full_C.txt" | sed 's/[^0-9]*//g' > /tmp/Spells1Full.txt
adb push /tmp/Spells1Full.txt /sdcard/coc/Spells1Full.txt
convert '/tmp/scr.png[56x21+286+434]' /tmp/cc.png
./ocrutil/OcrUtil KeepPixels /tmp/cc.png /tmp/cc_C.png ./ocrutil/whitelist.txt
tesseract /tmp/cc_C.png /tmp/cc_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/cc_C.txt" | sed 's/[^0-9]*//g' > /tmp/cc.txt
adb push /tmp/cc.txt /sdcard/coc/cc.txt
convert '/tmp/scr.png[40x20+410+433]' /tmp/ccSpell.png
./ocrutil/OcrUtil KeepPixels /tmp/ccSpell.png /tmp/ccSpell_C.png ./ocrutil/whitelist.txt
tesseract /tmp/ccSpell_C.png /tmp/ccSpell_C --tessdata-dir ~/Desktop/gh/remote_sh/tessdata -l coc1
cat "/tmp/ccSpell_C.txt" | sed 's/[^0-9]*//g' > /tmp/ccSpell.txt
adb push /tmp/ccSpell.txt /sdcard/coc/ccSpell.txt
