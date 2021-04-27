#!/bin/bash
echo "|------------------------------------------------------------------------------------------------|"
printf "| %-24s | %-12s | %-16s | %-19s | %-11s |\n" "VIDEO ID" "MESSAGE SIZE" "NAIVE VIDEO SIZE" "ENRICHED VIDEO SIZE" "ENRICH COST"
echo "|--------------------------|--------------|------------------|---------------------|-------------|"

for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    message_size=$(wc -c ./messages/$videoid.txt | cut -f 1 -d ' ')
    naive_size=$(wc -c ./videos/av1-naive/$videoid.ivf | cut -f 1 -d ' ')
    enriched_size=$(wc -c ./videos/av1-enriched/$videoid.ivf | cut -f 1 -d ' ')
    enrich_cost=$(($enriched_size-$naive_size))

    printf "| %-24s | %-12s | %-16s | %-19s | %-11s |\n" $videoid $message_size $naive_size $enriched_size $enrich_cost
done

echo "|------------------------------------------------------------------------------------------------|"