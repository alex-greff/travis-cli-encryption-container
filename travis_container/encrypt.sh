#!/bin/bash

echo "Logging into Travis"

travis login

# TODO: list
# 1. encrypt file/all files in directory
# 2. Add option to use github token

travis logout --com

