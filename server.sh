rm -f out
mkfifo out
trap "rm -f out" EXIT
while true
do
  cat out | nc -l 1500 >>( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
    while read line
    do
      line=$(echo "$line" | tr -d '[\r\n]') 
	  
      printf "%s\n%s " "ResponseFromServer" "$line"   > out
    done
  )
done