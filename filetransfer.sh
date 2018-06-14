rm /tmp/file.tmp
echo "test" > /tmp/test.tmp
nc localhost 9001 < /tmp/test.tmp
if [ ! -f /tmp/file.tmp ]; then
  echo "File transfer server not running. Starting.."
	while true; do
		nc -l 9001 > /tmp/file.tmp
	done &
else
    echo "file transfer server already running"
fi
