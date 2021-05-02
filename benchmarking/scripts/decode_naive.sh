#!/bin/bash
JOBS_FILE="./scripts/tmp/decode_naive.jobs"
> $JOBS_FILE

for filename in ./videos/av1-naive/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    printf "[Decode naive] Enqueueing case %s...\n" $videoid

    COMMAND="./bin/aomdec $filename -o ./videos/decoded-naive/$videoid.y4m > results/full_logs/decode_naive/$videoid.log 2>&1"
    echo $COMMAND >> $JOBS_FILE
done

parallel --jobs=$(nproc) < $JOBS_FILE