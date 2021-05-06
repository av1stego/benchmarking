#!/bin/bash
./bin/rav1e -y ./videos/raw/$VIDEO_ID.y4m --speed 6 --threads 1 --output ./videos/av1-naive/$VIDEO_ID.ivf > results/full_logs/encode_naive/$VIDEO_ID.log 2>&1
