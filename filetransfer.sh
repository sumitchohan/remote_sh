rm ~/Desktop/tmp/file.tmp
echo "test" > ~/Desktop/tmp/test.tmp
nc localhost 9001 < ~/Desktop/tmp/test.tmp
if [ ! ~/Desktop/tmp/file.tmp ]; then
    echo "file transfer server not running"
else
	echo "file transfer server is running"
fi
