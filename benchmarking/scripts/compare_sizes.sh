#!/bin/bash
echo "|-------------------------------------------------------------------------------------------------------------------|"
printf "| %-24s | %-16s | %-12s | %-16s | %-19s | %-11s |\n" "VIDEO ID" "MESSAGE ID" "MESSAGE SIZE" "NAIVE VIDEO SIZE" "ENRICHED VIDEO SIZE" "ENRICH COST"
echo "|--------------------------|------------------|--------------|------------------|---------------------|-------------|"

for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    for hidden_msg_filename in ./messages/$videoid/*; do
        hidden_msg_name=$(basename $hidden_msg_filename)
        hidden_msg_id=${hidden_msg_name%.*}
        case_id=$(printf "%s_%s" $videoid $hidden_msg_id)

        message_size=$(wc -c ./messages/$videoid/$hidden_msg_id.txt | cut -f 1 -d ' ')
        naive_size=$(wc -c ./videos/av1-naive/$videoid.ivf | cut -f 1 -d ' ')
        enriched_size=$(wc -c ./videos/av1-enriched/$case_id.ivf | cut -f 1 -d ' ')
        enrich_cost=$(($enriched_size-$naive_size))

        printf "| %-24s | %-16s | %-12s | %-16s | %-19s | %-11s |\n" $videoid $hidden_msg_id $message_size $naive_size $enriched_size $enrich_cost
    done
done

echo "|-------------------------------------------------------------------------------------------------------------------|"
