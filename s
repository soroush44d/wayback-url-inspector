
#!/bin/bash

function show_stamp(){
    echo "Checking For Valid Stamps"
    input_url=$(cat )
    echo " Checkin On : $input_url "
    echo "$input_url" |while IFS= read -r line; do
        status_code=$(echo "$line" | cut -d " " -f 5)
        time_stamp=$(echo "$line" | cut -d " " -f 2)
        
        if [[ $status_code =~ ^[24]0[0123] ]]; then
            echo " --------------------------------------------------- ">>wayback_result/result.txt
            echo "Fetching Content On $url | with Code : $status_code"
            echo "Url = $url " >> wayback_result/result.txt
            echo "Code :$status_code Stamp:$time_stamp">>wayback_result/result.txt
            curl -Lks "https://web.archive.org/web/$time_stamp/$url" >>wayback_result/result.txt
        fi
    done
    echo "-----------"
}

cat $1 | grep -E "txt|js|json" > filterd_url.txt
mkdir -p wayback_result

while IFS= read -r url; do
    echo "Working ON : $url"
    curl -kLs "https://www.web.archive.org/cdx/search/cdx?url=$url" | show_stamp
done < filterd_url.txt
