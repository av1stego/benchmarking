#!/bin/bash
MESSAGE_CONTENT=$(cat ./messages/$MESSAGE_ID.txt)

./bin/rav1e-lcmg -y ./videos/raw/$VIDEO_ID.y4m --speed 6 --threads 1 --output ./videos/av1-enriched/$CASE_ID.ivf --hidden-string "$MESSAGE_CONTENT" --hidden-bits-padding $PADDING --hidden-bits-offset $OFFSET > results/enrich_outputs/$CASE_ID.txt 2> results/full_logs/encode_enriched/$CASE_ID.log
