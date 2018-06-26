echo "time - $(date +%S_%N)"
adb shell screencap /sdcard/scr.raw
echo "time - $(date +%S_%N)"
adb pull /sdcard/scr.raw
echo "time - $(date +%S_%N)"
tail -c +13 scr.raw > scr.rgba
hexdump -e '/4 "%d"' -s 0 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 4 -n 4 scr.raw
hexdump -e '/4 "%d"' -s 8 -n 4 scr.raw
# convert -size 800x666 -depth 8 scr.rgba /tmp/scr.png
convert -size 1600x1332 -depth 8 scr.rgba /tmp/scr.png
echo "time - $(date +%S_%N)"