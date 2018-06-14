adb shell screencap /sdcard/scr.raw
adb pull /sdcard/scr.raw
tail -c +13 scr.raw > scr.rgba
hexdump -e '/4 "%d"' -s 0 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 4 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 8 -n 4 scr.raw
convert -size 800x666 -depth 8 scr.rgba scr.png