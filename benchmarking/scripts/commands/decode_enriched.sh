#!/bin/bash
HIDDEN_MESSAGE_OUTPUT_FILE=results/decode_outputs/$CASE_ID.txt ./bin/aomdec-lcmg ./videos/av1-enriched/$CASE_ID.ivf -o ./videos/decoded-enriched/$CASE_ID.y4m 2> results/full_logs/decode_enriched/$CASE_ID.log
