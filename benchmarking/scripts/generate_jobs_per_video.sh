#!/bin/bash
COMMAND="$1"

JOBS_FILE="./scripts/tmp/$COMMAND.jobs"
> $JOBS_FILE

declare -a VIDEOS=()

for case_filename in ./cases/*.txt; do
    while read case_definition; do
        IFS=' ' read -ra ADDR <<< "$case_definition"
        VIDEO_ID=${ADDR[0]}

        if [[ ! "${VIDEOS[@]}" =~ "$VIDEO_ID" ]]; then
            VIDEOS+=($VIDEO_ID)
        fi
    done < $case_filename
done

for VIDEO_ID in ${VIDEOS[@]}; do
    echo "VIDEO_ID=$VIDEO_ID scripts/commands/$COMMAND.sh" >> $JOBS_FILE
done
