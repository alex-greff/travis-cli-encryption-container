#!/bin/bash

# --- Args ---
# $1 file/directory path of file(s) to encrypt
# $2 repository to tie encryption to

TARGET_LOCATION="/app/toEncrypt"
PARENT_TARGET_LOCATION=$1 # The target location on the user's machine
TARGET_REPO=$2

cd "$TARGET_LOCATION"

echo "> Logging into Travis"

travis login

if [[ -d $TARGET_LOCATION ]]; then
    echo "> Target directory detected:"

    echo "> Compressing directory contents"

    # Construct the tar filename
    TAR_FILE_NAME=$(basename "$PARENT_TARGET_LOCATION").tgz

    # Compress the contents of the directory
    tar -zcvf ./$TAR_FILE_NAME .

    echo "> Encrypting $TAR_FILE_NAME"

    # Encrypt the compressed file
    travis encrypt-file $TAR_FILE_NAME -r $TARGET_REPO

elif [[ -f $TARGET_LOCATION ]]; then
    echo "> Target file detected:"

    echo "> Encrypting $(basename "$PARENT_TARGET_LOCATION")"

    # Encrypt the file
    travis encrypt-file $file -r $TARGET_REPO

else
    echo "> ERROR: Invalid encrypt file/directory provided: $PARENT_TARGET_LOCATION" >&2
fi

echo "> Logging out of Travis"

travis logout --com &> /dev/null

echo "> Encryption complete!"