cd cv
echo "running find objest server"
python find_objects_1.py & pid=$!
echo $pid>/tmp/pid_f_o.txt
cd ..
echo "run pyramid app"
python pyramidapp.py & pid=$!
echo $pid>/tmp/pid_p_a.txt
echo "run server.sh"
source server.sh & pid=$!
echo $pid > /tmp/pid_s.txt