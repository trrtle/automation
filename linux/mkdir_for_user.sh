#! /bin/bash

HELP_TEXT="
Create directory(s) for the specified user

mkdir_for_user -u [user] -d [directory] -p

-h, --help          show brief help
-u, --user          specify the user for which to create the directory(s)
-d, --directory     specify the directory(s) to be created
-p, --parent        create parent directories

script requires root password
"

if [[ $# -eq 0 ]]; then
echo "$HELP_TEXT"
else
while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--user)
            OWNER=$2
            shift 2
        ;;
        -d|--dir)
            DIRECTORY=$2
            shift 2
        ;;
        -p|--parent)
        PARENT=1
        shift
        ;;
        -h|--help|*)
            echo "$HELP_TEXT"
            break
        ;;
    esac
done
fi

if [[ -n $OWNER ]] && [[ -n $DIRECTORY ]] ; then
    if [[ $PARENT -eq 1 ]]; then
        PARENT_DIR=$(echo $DIRECTORY | cut -d "/" -f1)
        sudo mkdir -pv $DIRECTORY && sudo chown -Rv $OWNER $PARENT_DIR && sudo chgrp -Rv $OWNER $PARENT_DIR
    else
    sudo mkdir -v $DIRECTORY && sudo chown -v $OWNER $DIRECTORY && sudo chgrp -v $OWNER $DIRECTORY 
    fi
fi