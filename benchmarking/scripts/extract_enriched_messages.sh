#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$videoid.txt > ./results/hidden_messages/$videoid.txt
done