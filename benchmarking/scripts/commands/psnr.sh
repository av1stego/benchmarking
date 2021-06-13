#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

NAIVE_VIDEO="./videos/av1-naive/$VIDEO_ID.ivf"
ENRICHED_VIDEO="./videos/av1-enriched/$CASE_ID.ivf"

RESULT=$(ffmpeg -i $NAIVE_VIDEO -i $ENRICHED_VIDEO -lavfi psnr="" -f null - 2>&1 | tail -n 1)

echo $CASE_ID,$RESULT
