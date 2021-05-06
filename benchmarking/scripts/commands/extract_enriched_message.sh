#!/bin/bash
python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$CASE_ID.txt $PADDING $OFFSET message > ./results/hidden_messages/$CASE_ID.hex
python3 ./scripts/python/retrieve_decoded_message.py ./results/decode_outputs/$CASE_ID.txt $PADDING $OFFSET stats > ./results/hidden_information_stats/$CASE_ID.txt
