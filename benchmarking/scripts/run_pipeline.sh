printf "Clearing the workbench...\n"
./scripts/clear.sh

printf "Converting videos to Y4M...\n"
./scripts/convert_to_y4m.sh

printf "Running encoding jobs...\n"
./scripts/encode_naive.sh &
./scripts/encode_enriched.sh &
wait

printf "Running decoding jobs...\n"
./scripts/decode_naive.sh &
./scripts/decode_enriched.sh &
wait

printf "Extracting hidden messages...\n"
./scripts/extract_enriched_messages.sh

./scripts/verify_integrity.sh && \
./scripts/compare_sizes.sh