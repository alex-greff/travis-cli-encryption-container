#!/bin/bash

# --- Args ---
# $1 directory path containing the file(s) to encrypt
# $2 repository to tie encryption to

TARGET_LOCATION="/app/toEncrypt"
PARENT_TARGET_LOCATION=$1 # The target location on the user's machine
TARGET_REPO=$2

cd "$TARGET_LOCATION"

NUM_FILES=`expr $(ls -afq | wc -l) - 2` # Note: must subtract 2 b/c . and .. are included

echo "Num files $NUM_FILES"

echo "> Logging into Travis"

travis login

if [[ -d $TARGET_LOCATION ]]; then
    if [ $NUM_FILES -le 1 ]; then
        echo "> Single file detected: encrypting file"

        # Get the file name
        FILE_NAME=`ls | head -1`

        # Encrypt the file
        travis encrypt-file $FILE_NAME -r $TARGET_REPO
    else
        echo "> More than one file detected: compressing directory contents"

        # Construct the tar filename
        TAR_FILE_NAME=$(basename "$PARENT_TARGET_LOCATION").tgz

        # Compress the contents of the directory
        tar -zcvf ./$TAR_FILE_NAME .

        echo "> Encrypting $TAR_FILE_NAME"

        # Encrypt the compressed file
        travis encrypt-file $TAR_FILE_NAME -r $TARGET_REPO
    fi
else
    echo "> ERROR: Invalid file provided: '$PARENT_TARGET_LOCATION' is not a directory" >&2
fi

echo "> Logging out of Travis"

travis logout --com &> /dev/null

echo "> Encryption complete!"