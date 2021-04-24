#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$videoid.txt message > ./results/hidden_messages/$videoid.hex
    python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$videoid.txt stats > ./results/hidden_information_stats/$videoid.txt
done