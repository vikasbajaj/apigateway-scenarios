$ cat index.sh
handler () {
    set -e
    
    for i in {1..5}
    do
        echo "value of i is $i"
    done
    
    random_num=$(echo $(( $RANDOM % 10 )))
    echo $random_num
    
    if test $random_num -gt 5
    then
        RESPONSE="{\"statusCode\": 200}"
         echo $RESPONSE >&2
    else
        RESPONSE="{\"statusCode\": 204}"
         echo $RESPONSE >&2
    fi
}