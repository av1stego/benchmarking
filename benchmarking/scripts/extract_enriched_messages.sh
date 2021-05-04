#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    for hidden_msg_filename in ./messages/$videoid/*; do
        hidden_msg_name=$(basename $hidden_msg_filename)
        hidden_msg_id=${hidden_msg_name%.*}
        hidden_message=$(cat ./messages/$videoid/$hidden_msg_id.txt)
        case_id=$(printf "%s_%s" $videoid $hidden_msg_id)

        padding=0
        offset=0

        printf "[Extract enriched message] Enqueueing case %s...\n" $case_id

        python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$case_id.txt $padding $offset message > ./results/hidden_messages/$case_id.hex
        python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$case_id.txt $padding $offset stats > ./results/hidden_information_stats/$case_id.txt
    done
done