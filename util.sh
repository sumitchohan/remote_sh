# sendMessage "localhost" "8080" "Hello"
function sendMessage {
    echo "$3" | nc "$1" "$2" |   while read line; do
        if [[ $line == "<EOF>" ]]; then
			echo "breaking"
            break;
            break;
        else
            echo $line
        fi
    done
	break;
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