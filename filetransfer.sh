rm /tmp/file.tmp
echo "test" > /tmp/test.tmp
nc localhost 9001 < /tmp/test.tmp
if [ ! /tmp/file.tmp ]; then
    echo "file transfer server not running"
else
	echo "file transfer server is running"
fi
