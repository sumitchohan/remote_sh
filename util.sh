# sendMessage "localhost" "8080" "Hello"
function sendMessage {
    while read line; do
        if [[ $line == "ENDRESPONSE" ]]; then
            break
        else
            echo $line
        fi
    done < <(echo $3 | netcat "$1" "$2" <<< "$*")
}

