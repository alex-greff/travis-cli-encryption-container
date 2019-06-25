# Travis CLI Encryption Container

A simple npm script and docker container that allows for Travis CI file encryption to be done quickly.

## Why this?

The main purpose of this tool came about due to how annoying it is to encrypt files with for Travis CI on Windows due an encryption bug with the windows version of the Travis CLI causing the encrypted files to fail decrypting on during the Travis build.

## What it does

A simple shell script encapsulates a docker container with the Travis CLI (properly) installed which allows for a file to easily be encrypted.

## Dependencies

* Have Docker installed
* Have a command-line that with bash scripting support

## Usage

TODO: complete
