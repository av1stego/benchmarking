#!/bin/bash
for filename in ./videos/av1-naive/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}
    ./bin/aomdec $filename -o ./videos/decoded-naive/$videoid.y4m > /dev/null
done