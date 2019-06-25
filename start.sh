#!/bin/bash

# --- Args ---
# $1 file/directory path of file(s) to encrypt
# $2 repository to tie encryption to
# $3 github username
# $4 github password

IMAGE_NAME="alexgreff/travis_cli_encryption_container"
CURR_DIR=`pwd`

# Build the container
docker build -t $IMAGE_NAME "./travis_container"

# Run the container
docker run -it -v "/$CURR_DIR/$1:/app/file" $IMAGE_NAME bash -c "sed -i 's/\r$//' /app/scripts/encrypt.sh; bash /app/scripts/encrypt.sh $1 $2 $3 $4"

# Interactive bash mode (for debugging/manual control)
# docker run -it -v "/$CURR_DIR/$1:/app/file" $IMAGE_NAME bash -c "sed -i 's/\r$//' /app/scripts/encrypt.sh; bash"