#!/bin/bash
for filename in ./videos/dataset/*; do
    videoname=$(basename $filename)
    ffmpeg -y -i $filename -pix_fmt yuv420p ./videos/raw/${videoname%.*}.y4m
done

