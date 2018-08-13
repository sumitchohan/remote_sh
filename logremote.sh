dt=$(date '+%Y-%m-%dT%H_%M_%S');
echo "$dt - $@">>logs.log
logs=$(tail -n 20 logs.log)
echo "$logs">logs.log
curl -d "$logs" -X POST https://api.keyvalue.xyz/d291d631/logKey -k -s