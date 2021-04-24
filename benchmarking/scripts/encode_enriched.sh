#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/rav1e-lcmg -y $filename  --threads $(nproc) --speed 10 --output ./videos/av1-enriched/$videoid.ivf --hidden-string $(cat ./messages/$videoid.txt) > results/enrich_outputs/$videoid.txt
done