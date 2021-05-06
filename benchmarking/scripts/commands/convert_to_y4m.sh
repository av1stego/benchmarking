#!/bin/bash
ffmpeg -y -i ./videos/dataset/$VIDEO_ID.mp4 -pix_fmt yuv420p ./videos/raw/$VIDEO_ID.y4m > results/full_logs/convert_to_y4m/$VIDEO_ID.log 2>&1
