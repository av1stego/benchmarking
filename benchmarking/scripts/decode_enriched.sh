#!/bin/bash
for filename in ./videos/av1-enriched/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/aomdec-lcmg $filename -o ./videos/decoded-enriched/$videoid.y4m > results/decode_outputs/$videoid.txt
done