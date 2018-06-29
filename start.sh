cd cv
python find_objects_1.py & pid=$!
echo $pid>/tmp/pid_f_o.txt
cd ..
python pyramidapp.py & pid=$!
echo $pid>/tmp/pid_p_a.txt