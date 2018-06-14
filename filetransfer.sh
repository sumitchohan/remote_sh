rm /tmp/file.tmp
echo "test" > /tmp/test.tmp
nc localhost 9001 < /tmp/test.tmp
if [ ! -f /tmp/file.tmp ]; then
    echo "file transfer server not running"
else
	while true; do
		nc -l 9001 > /tmp/file.tmp
	done
fi
