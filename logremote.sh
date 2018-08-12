dt=$(date '+%Y-%m-%dT%H_%M_%S');
echo "$dt - $@ <br/>">>logs.log
logs=$(head -n 20 logs.log)
curl -d "$logs" -X POST https://api.keyvalue.xyz/d291d631/logKey -k -s