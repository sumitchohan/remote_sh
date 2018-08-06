dt=$(date '+%Y-%m-%dT%H_%M_%S');
curl -d "$dt - $1" -X POST https://api.keyvalue.xyz/d291d631/logKey -k -s