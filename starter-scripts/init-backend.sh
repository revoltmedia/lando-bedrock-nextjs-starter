#!/bin/sh

# Lando/Bedrock project setup script
# By: Bear at Revolt Media - https://github.com/chaoticbear
# Project: https://github.com/revoltmedia/lando-bedrock-starter

BACKEND_DIR=/app/backend

yes_or_no() {
    while true; do
        read -r yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

printf 'Create Bedrock project in %s?\n
[y/n]' "$BACKEND_DIR"
if yes_or_no; then
    mkdir "$BACKEND_DIR"
    cd "$BACKEND_DIR" || echo "Error: $BACKEND_DIR wasn't created."
    composer create-project roots/bedrock
    
    if [ -d "$BACKEND_DIR/bedrock" ]; then
        SOURCE_DIR="$BACKEND_DIR/bedrock"
        
        echo "Moving contents of $SOURCE_DIR to $BACKEND_DIR"

        find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -exec mv -t $BACKEND_DIR -- {} +
        rm -rf "$SOURCE_DIR"
    else
        echo "The Bedrock project wasn't created"
        exit;
    fi
fi


printf 'A .env file will now be created with salts generated. \n
Press ctrl+c to abort or enter to continue.'

read -r ans