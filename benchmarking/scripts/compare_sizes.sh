#!/bin/bash
for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    du -S -B1 ./videos/av1-naive/$videoid.ivf
    du -S -B1 ./videos/av1-enriched/$videoid.ivf
done

