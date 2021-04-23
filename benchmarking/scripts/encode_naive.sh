#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/rav1e -y $filename  --threads $(nproc) --output ./videos/av1-naive/$videoid.ivf
done