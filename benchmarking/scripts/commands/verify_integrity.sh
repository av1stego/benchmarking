#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

RETCODE=0

printf "[Verify integrity] Verifying case %s... " $CASE_ID
    
original_hidden_message=$(cat ./messages/$MESSAGE_ID.txt)
written_hidden_message_hex=$(xxd -p ./results/hidden_messages/$CASE_ID.hex)
read -d '' written_hidden_message < <(echo $written_hidden_message_hex | xxd -r -p)

if [[ $original_hidden_message == $written_hidden_message ]]; then
    printf "${BOLD}${GREEN}OK"
    echo "OK" >> ./results/integrity_verifications/$CASE_ID.txt
    ERROR=0
else
    printf "${BOLD}${RED}ERROR"
    echo "ERROR" >> ./results/integrity_verifications/$CASE_ID.txt
    ERROR=1
fi

printf "${ENDCOLOR}\n"

if [[ $ERROR != 0 ]]; then
    RETCODE=$ERROR

    echo -e "${BOLD}Original message:${ENDCOLOR}\\n$original_hidden_message"
    echo -e "${BOLD}Written message:${ENDCOLOR}\\n$written_hidden_message"

    exit $RETCODE
fi
