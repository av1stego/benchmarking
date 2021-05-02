#!/bin/bash
JOBS_FILE="./scripts/tmp/convert_to_y4m.jobs"
> $JOBS_FILE

for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    printf "[Convert to Y4M] Enqueueing case %s...\n" $videoid

    COMMAND="ffmpeg -y -i $filename -pix_fmt yuv420p ./videos/raw/$videoid.y4m > results/full_logs/convert_to_y4m/$videoid.log 2>&1"

    echo $COMMAND >> $JOBS_FILE
done

parallel --jobs=$(nproc) < $JOBS_FILE
