#!/bin/bash
COMMAND="$1"
HEADER_COMMAND="$2"
FOOTER_COMMAND="$3"

if [[ ! -z $HEADER_COMMAND ]]; then
    ./scripts/commands/$HEADER_COMMAND.sh
fi

for case_filename in ./cases/*.txt; do
    while read case_definition; do
        IFS=' ' read -ra ADDR <<< "$case_definition"
        VIDEO_ID=${ADDR[0]}
        MESSAGE_ID=${ADDR[1]}
        PADDING=${ADDR[2]}
        OFFSET=${ADDR[3]}
        CASE_ID=$(printf "%s_%s_%s_%s" $VIDEO_ID $MESSAGE_ID $PADDING $OFFSET)

        VIDEO_ID=$VIDEO_ID MESSAGE_ID=$MESSAGE_ID PADDING=$PADDING OFFSET=$OFFSET CASE_ID=$CASE_ID ./scripts/commands/$COMMAND.sh
    done < $case_filename
done

if [[ ! -z $FOOTER_COMMAND ]]; then
    ./scripts/commands/$FOOTER_COMMAND.sh
fi
