# sendMessage "localhost" "8080" "Hello"
function sendMessage {
    while read line; do
        if [[ $line == "<EOF>" ]]; then
            break
        else
            echo $line
        fi
    done < <(echo "$3" | nc "$1" "$2" <<< "$*")
}

