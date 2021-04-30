#!/bin/bash
for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/rav1e -y $filename --speed 6 --threads $(nproc) --output ./videos/av1-naive/$videoid.ivf
    # ./bin/rav1e-lcmg -y $filename --speed 6 --threads $(nproc) --output ./videos/av1-naive/$videoid.ivf > /dev/null
done