#!/bin/sh

# Lando/NextJS project setup script
# By: Bear at Revolt Media - https://github.com/chaoticbear
# Project: https://github.com/revoltmedia/lando-bedrock-nextjs-starter

FRONTEND_DIR='frontend'

yes_or_no() {
    while true; do
        read -r yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

echo "Project name? (slug-case only): "
read -r PROJECT_NAME 

if [ -d "$FRONTEND_DIR" ]; then
    printf '\n
./%s already exists. \n
Would you like to DELETE and recreate it? Otherwise this script exits. \n
THIS WILL DELETE ANY WORK YOU'\''VE DONE IN ./%s!!!\n
[y/n]' "$FRONTEND_DIR" "$FRONTEND_DIR"
    if yes_or_no; then
        rm -rf ./$FRONTEND_DIR

        if [ -d "$FRONTEND_DIR" ]; then
            printf '\n
Deleting with your user account didn'\''t work. \n
Try again using lando as root?\n
[y/n]';
            if yes_or_no; then
                # Use lando to remove directory because some files may be owned by root.
                # Alternative would be to require sudo.
                lando ssh -s frontend -c "rm -rf /app/$FRONTEND_DIR" -u root
            fi
        fi

        if [ -d "$FRONTEND_DIR" ]; then
            printf '\n
Failed to delete ./%s\n
Most likely continuing will lead to more errors.\n
Would you like to continue anyway?\n
[y/n]' "$FRONTEND_DIR"
            if ! yes_or_no; then
                exit;
            fi
        fi
    else
        exit;
    fi
fi

printf 'Create NextJS project named %s in /%s?\n
[y/n]' "$PROJECT_NAME" "$FRONTEND_DIR"
if yes_or_no; then
    mkdir frontend
    sh -c "lando yarn create next-app $PROJECT_NAME"

    if [ -d "$FRONTEND_DIR/$PROJECT_NAME" ]; then
        SOURCE_DIR="./$FRONTEND_DIR/$PROJECT_NAME"
        
        echo "Moving contents of $SOURCE_DIR to ./$FRONTEND_DIR"

        mv "$SOURCE_DIR"/* "./$FRONTEND_DIR/"
        mv "$SOURCE_DIR"/.* "./$FRONTEND_DIR/"
        rm -rf "$SOURCE_DIR"
    else
        echo "The NextJS project wasn't created"
        exit;
    fi
else
    exit;
fi

printf 'Build / rebuild lando?\n
    [y/n]'
if yes_or_no; then
    lando rebuild -y
else
    exit;
fi