#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

echo -e "${BOLD}|--------------------------------------------------------------------------------------------------------------------------|${ENDCOLOR}"
printf "| ${BOLD}%-24s${ENDCOLOR} | ${BOLD}%-16s${ENDCOLOR} | ${BOLD}%-16s${ENDCOLOR} | ${BOLD}%-19s${ENDCOLOR} | ${BOLD}%-19s${ENDCOLOR} | ${BOLD}%-11s${ENDCOLOR} |\n" "VIDEO ID" "MESSAGE ID" "NAIVE VIDEO SIZE" "ENRICHED VIDEO SIZE" "MESSAGE SIZE" "ENRICH COST"
echo -e "${BOLD}|--------------------------|------------------|------------------|---------------------|---------------------|-------------|${ENDCOLOR}"

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
        enrich_cost="$(($enriched_size-$naive_size))"

        if (( $enrich_cost > $message_size )); then
            result_color_tag=$RED
        else
            result_color_tag=$GREEN
        fi

        printf "| %-24s | %-16s | %-16s | %-19s | %-19s | ${BOLD}${result_color_tag}%-11s${ENDCOLOR} |\n" $videoid $hidden_msg_id $naive_size $enriched_size $message_size $enrich_cost
    done
done

echo "|--------------------------------------------------------------------------------------------------------------------------|"
