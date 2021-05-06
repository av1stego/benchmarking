#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

MESSAGE_SIZE=$(wc -c ./messages/$MESSAGE_ID.txt | cut -f 1 -d ' ')
NAIVE_SIZE=$(wc -c ./videos/av1-naive/$VIDEO_ID.ivf | cut -f 1 -d ' ')
ENRICHED_SIZE=$(wc -c ./videos/av1-enriched/$CASE_ID.ivf | cut -f 1 -d ' ')
ENRICH_COST="$(($ENRICHED_SIZE-$NAIVE_SIZE))"

if (( $ENRICH_COST > $MESSAGE_SIZE )); then
    RESULT_COLOR_TAG=$RED
else
    RESULT_COLOR_TAG=$GREEN
fi

printf "| %-24s | %-16s | %-16s | %-19s | %-19s | ${BOLD}${RESULT_COLOR_TAG}%-11s${ENDCOLOR} |\n" $VIDEO_ID $MESSAGE_ID $NAIVE_SIZE $ENRICHED_SIZE $MESSAGE_SIZE $ENRICH_COST
