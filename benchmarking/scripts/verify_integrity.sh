#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

RETCODE=0

for filename in ./videos/raw/*; do
    videoname=$(basename $filename)
    videoid=${videoname%.*}

    for hidden_msg_filename in ./messages/$videoid/*; do
        hidden_msg_name=$(basename $hidden_msg_filename)
        hidden_msg_id=${hidden_msg_name%.*}
        case_id=$(printf "%s_%s" $videoid $hidden_msg_id)

        printf "[Verify integrity] Verifying case %s... " $case_id
         
        original_hidden_message=$(cat ./messages/$videoid/$hidden_msg_id.txt)
        written_hidden_message_hex=$(xxd -p ./results/hidden_messages/$case_id.hex)
        read -d '' written_hidden_message < <(echo $written_hidden_message_hex | xxd -r -p)

        if [[ $original_hidden_message == $written_hidden_message ]]; then
            printf "${BOLD}${GREEN}OK"
            ERROR=0
        else
            printf "${BOLD}${RED}ERROR"
            ERROR=1
        fi

        printf "${ENDCOLOR}\n"

        if [[ $ERROR != 0 ]]; then
            RETCODE=$ERROR

            echo -e "${BOLD}Original message:${ENDCOLOR}\\n$original_hidden_message"
            echo -e "${BOLD}Written message:${ENDCOLOR}\\n$written_hidden_message"

            exit $RETCODE
        fi
    done
done
