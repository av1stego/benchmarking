#!/bin/bash
COMMAND="$1"

JOBS_FILE="./scripts/tmp/$COMMAND.jobs"
> $JOBS_FILE

for case_filename in ./cases/*.txt; do
    while read case_definition; do
        IFS=' ' read -ra ADDR <<< "$case_definition"
        VIDEO_ID=${ADDR[0]}
        MESSAGE_ID=${ADDR[1]}
        PADDING=${ADDR[2]}
        OFFSET=${ADDR[3]}
        CASE_ID=$(printf "%s_%s_%s_%s" $VIDEO_ID $MESSAGE_ID $PADDING $OFFSET)

        echo "VIDEO_ID=$VIDEO_ID MESSAGE_ID=$MESSAGE_ID PADDING=$PADDING OFFSET=$OFFSET CASE_ID=$CASE_ID scripts/commands/$COMMAND.sh" >> $JOBS_FILE
    done < $case_filename
done

parallel --progress --jobs=$(nproc) < $JOBS_FILE
