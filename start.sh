threads=$(fuser 8951/tcp)
while read line; do
	echo "killing - $line"
	kill $line
done < <(echo $threads | tr ' ' '\n')

threads=$(fuser 8952/tcp)
while read line; do
	echo "killing - $line"
	kill $line
done < <(echo $threads | tr ' ' '\n')

threads=$(fuser 8901/tcp)
while read line; do
	echo "killing - $line"
	kill $line
done < <(echo $threads | tr ' ' '\n')


cd ~/Desktop/gh/remote_sh/cv
python find_objects_1.py &
cd ~/Desktop/gh/remote_sh
./linux.sh &
python find_objects_1.py &
python pyramidapp.py & 
source server.sh &
