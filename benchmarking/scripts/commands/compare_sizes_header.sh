#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

echo -e "${BOLD}|--------------------------------------------------------------------------------------------------------------------------|${ENDCOLOR}"
printf "| ${BOLD}%-24s${ENDCOLOR} | ${BOLD}%-16s${ENDCOLOR} | ${BOLD}%-16s${ENDCOLOR} | ${BOLD}%-19s${ENDCOLOR} | ${BOLD}%-19s${ENDCOLOR} | ${BOLD}%-11s${ENDCOLOR} |\n" "VIDEO ID" "MESSAGE ID" "NAIVE VIDEO SIZE" "ENRICHED VIDEO SIZE" "MESSAGE SIZE" "ENRICH COST"
echo -e "${BOLD}|--------------------------|------------------|------------------|---------------------|---------------------|-------------|${ENDCOLOR}"
