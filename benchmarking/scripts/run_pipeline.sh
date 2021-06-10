BOLD="\e[1m"
ENDCOLOR="\e[0m"

echo -e "${BOLD}Clearing the workbench...${ENDCOLOR}"
./scripts/clear.sh

echo -e "${BOLD}Converting videos to Y4M...${ENDCOLOR}"
./scripts/generate_jobs_per_video.sh convert_to_y4m
./scripts/execute_parallel.sh convert_to_y4m

echo -e "${BOLD}Running encoding jobs...${ENDCOLOR}"
./scripts/generate_jobs_per_video.sh encode_naive
./scripts/generate_jobs.sh encode_enriched 

cat ./scripts/tmp/encode_naive.jobs >> ./scripts/tmp/encode.jobs
cat ./scripts/tmp/encode_enriched.jobs >> ./scripts/tmp/encode.jobs

./scripts/execute_parallel.sh encode

echo -e "${BOLD}Running decoding jobs...${ENDCOLOR}"
./scripts/generate_jobs_per_video.sh decode_naive
./scripts/generate_jobs.sh decode_enriched

cat ./scripts/tmp/decode_naive.jobs >> ./scripts/tmp/decode.jobs
cat ./scripts/tmp/decode_enriched.jobs >> ./scripts/tmp/decode.jobs

./scripts/execute_parallel.sh decode

echo -e "${BOLD}Extracting hidden messages...${ENDCOLOR}"
./scripts/execute_serial.sh extract_enriched_message

./scripts/execute_serial.sh verify_integrity

./scripts/execute_serial.sh stats_csv stats_csv_header > "results/stats/$(date).csv"
./scripts/execute_serial.sh stats stats_header stats_footer
