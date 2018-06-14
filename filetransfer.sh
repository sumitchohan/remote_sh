rm ~/Desktop/temp/file.tmp
echo "test" > ~/Desktop/temp/test.tmp
nc localhost 9001 < ~/Desktop/temp/test.tmp
if [ ! ~/Desktop/temp/file.tmp ]; then
    echo "file transfer server not running"
else
	echo "file transfer server is running"
fi
