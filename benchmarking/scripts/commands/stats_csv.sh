#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

MESSAGE_SIZE=$(wc -c ./messages/$MESSAGE_ID.txt | cut -f 1 -d ' ')
NAIVE_SIZE=$(wc -c ./videos/av1-naive/$VIDEO_ID.ivf | cut -f 1 -d ' ')
ENRICHED_SIZE=$(wc -c ./videos/av1-enriched/$CASE_ID.ivf | cut -f 1 -d ' ')
INTEGRITY_RESULT=$(cat ./results/integrity_verifications/$CASE_ID.txt)
ENRICH_COST="$(($ENRICHED_SIZE-$NAIVE_SIZE))"

(( $ENRICH_COST > $MESSAGE_SIZE )) && SIZE_RESULT_COLOR_TAG=$RED || SIZE_RESULT_COLOR_TAG=$GREEN
[[ $INTEGRITY_RESULT == *"OK"* ]] && INTEGRITY_RESULT_COLOR_TAG=$GREEN || INTEGRITY_RESULT_COLOR_TAG=$RED

printf "%s,%s,%s,%s,%s,%s\n" $CASE_ID $NAIVE_SIZE $ENRICHED_SIZE $MESSAGE_SIZE $ENRICH_COST $INTEGRITY_RESULT
