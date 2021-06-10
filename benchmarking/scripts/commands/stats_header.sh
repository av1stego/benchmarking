#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

echo -e "${BOLD}|------------------------------------------------------------------------------------------------------------------------------------|${ENDCOLOR}"
printf "| ${BOLD}%-48s${ENDCOLOR} | ${BOLD}%-16s${ENDCOLOR} | ${BOLD}%-19s${ENDCOLOR} | ${BOLD}%-12s${ENDCOLOR} | ${BOLD}%-11s${ENDCOLOR} | ${BOLD}%-9s${ENDCOLOR} |\n" "CASE ID" "NAIVE VIDEO SIZE" "ENRICHED VIDEO SIZE" "MESSAGE SIZE" "ENRICH COST" "INTEGRITY"
echo -e "${BOLD}|------------------------------------------------------------------------------------------------------------------------------------|${ENDCOLOR}"
