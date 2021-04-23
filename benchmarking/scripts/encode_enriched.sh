#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/rav1e-lcmg -y $filename  --threads $(nproc) --output ./videos/av1-enriched/$videoid.ivf --hidden-string "test" > results/enrich_outputs/$videoid.txt
done