#!/bin/bash
./bin/aomdec ./videos/av1-naive/$VIDEO_ID.ivf -o ./videos/decoded-naive/$VIDEO_ID.y4m > results/full_logs/decode_naive/$VIDEO_ID.log 2>&1
