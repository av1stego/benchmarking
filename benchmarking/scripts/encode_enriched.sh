#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    for hidden_msg_filename in ./messages/$videoid/*; do
        hidden_msg_name=$(basename $hidden_msg_filename)
        hidden_msg_id=${hidden_msg_name%.*}
        hidden_message=$(cat ./messages/$videoid/$hidden_msg_id.txt)
        case_id=$(printf "%s_%s" $videoid $hidden_msg_id)

        printf "Encoding case %s...\n" $case_id

        ./bin/rav1e-lcmg -y $filename --speed 6 --threads $(nproc) --output ./videos/av1-enriched/$case_id.ivf --hidden-string "$hidden_message" > results/enrich_outputs/$case_id.txt
    done
done