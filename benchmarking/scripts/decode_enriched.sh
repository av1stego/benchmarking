#!/bin/bash
JOBS_FILE="./scripts/tmp/decode_enriched.jobs"
> $JOBS_FILE

for filename in ./videos/av1-enriched/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    printf "[Decode enriched] Enqueueing case %s...\n" $videoid

    COMMAND="./bin/aomdec-lcmg $filename -o ./videos/decoded-enriched/$videoid.y4m > results/decode_outputs/$videoid.txt 2> results/full_logs/decode_enriched/$videoid.log"
    echo $COMMAND >> $JOBS_FILE
done

parallel --jobs=$(nproc) < $JOBS_FILE