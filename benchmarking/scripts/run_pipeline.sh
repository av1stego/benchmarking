BOLD="\e[1m"
ENDCOLOR="\e[0m"

echo -e "${BOLD}Clearing the workbench...${ENDCOLOR}"
./scripts/clear.sh

echo -e "${BOLD}Converting videos to Y4M...${ENDCOLOR}"
./scripts/execute_parallel.sh convert_to_y4m

echo -e "${BOLD}Running encoding jobs...${ENDCOLOR}"
./scripts/execute_parallel.sh encode_naive
./scripts/execute_parallel.sh encode_enriched

echo -e "${BOLD}Running decoding jobs...${ENDCOLOR}"
./scripts/execute_parallel.sh decode_naive
./scripts/execute_parallel.sh decode_enriched

echo -e "${BOLD}Extracting hidden messages...${ENDCOLOR}"
./scripts/execute_serial.sh extract_enriched_message

./scripts/execute_serial.sh verify_integrity && \
./scripts/execute_serial.sh compare_sizes compare_sizes_header compare_sizes_footer
