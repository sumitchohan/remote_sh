# sendMessage "localhost" "8080" "Hello"
sendMessage()
{
echo $(echo "$1" | tr 'n' ' ')  | nc "192.168.0.106" "8901"
}

# function processMessageFromServer {
# while true
# do

    # while read line; do
        # if [[ $line == "<EOF>" ]]; then
            # break
        # else
            # echo $line
        # fi
    # done < <(echo "$3" | nc "$1" "$2")
# done
# }