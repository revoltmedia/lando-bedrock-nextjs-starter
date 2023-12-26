#!/bin/sh

FRONTEND_DIR='frontend'

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

read -p "Project name? (slug-case only)" PROJECT_NAME 

if [ -d "$FRONTEND_DIR" ]; then
    printf "\n
    ./$FRONTEND_DIR already exists. \n
    Would you like to DELETE and recreate it? Otherwise this script exits. \n
    THIS WILL DELETE ANY WORK YOU'VE DONE IN ./$FRONTEND_DIR!!!"
    if yes_or_no ""; then
        rm -rf ./$FRONTEND_DIR

        if [ -d "$FRONTEND_DIR" ]; then
            printf "Deleting with your user account didn't work. \n
            Try again using lando as root?";
            if yes_or_no ""; then
                # Use lando to remove directory because some files may be owned by root.
                # Alternative would be to require sudo.
                lando ssh -s frontend -c "rm -rf /app/$FRONTEND_DIR" -u root
            fi
        fi

        if [ -d "$FRONTEND_DIR" ]; then
            printf "\n
                Failed to delete ./$FRONTEND_DIR\n
                Most likely continuing will lead to more errors.
                Would you like to continue anyway?
            "
            if yes_or_no ""; then
                continue;
            else
                exit;
            fi
        fi
    else
        exit;
    fi
fi

if yes_or_no "Create NextJS project named $PROJECT_NAME in /$FRONTEND_DIR?"; then
    mkdir frontend
    lando yarn create next-app $PROJECT_NAME

    echo "Moving contents of ./$FRONTEND_DIR/$PROJECT_NAME to ./$FRONTEND_DIR"
    mv ./$FRONTEND_DIR/$PROJECT_NAME/* ./$FRONTEND_DIR/
    mv ./$FRONTEND_DIR/$PROJECT_NAME/.* ./$FRONTEND_DIR/
    rm -rf ./$FRONTEND_DIR/$PROJECT_NAME
else
    exit;
fi

if yes_or_no "Build / rebuild lando?"; then
    lando rebuild -y
else
    exit;
fi