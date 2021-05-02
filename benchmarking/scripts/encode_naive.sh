#!/bin/bash
JOBS_FILE="./scripts/tmp/encode_naive.jobs"
> $JOBS_FILE

for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    case_id=$videoid

    printf "[Encode naive] Enqueueing case %s...\n" $case_id

    COMMAND="./bin/rav1e -y $filename --speed 6 --threads 1 --output ./videos/av1-naive/$case_id.ivf > results/full_logs/encode_naive/$case_id.log 2>&1"
    echo $COMMAND >> $JOBS_FILE
done

parallel --jobs=$(nproc) < $JOBS_FILE