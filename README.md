# Travis CLI Encryption Container

A simple bash script and docker container that allows for Travis CI file encryption to be done quickly and painlessly.

## Table of Contents
* [Why this?](#why-this)
* [What does it do?](#what-does-it-do)
* [Usage](#usage)

## Why this?

The main purpose of this tool came about due to how annoying it is to encrypt files with for Travis CI on Windows. Due to an encryption [bug](https://docs.travis-ci.com/user/encrypting-files/#caveat) with the windows version of the Travis CLI the encrypted files would fail to decrypt during the Travis CI build process.

## What does it do?

This tool is a simple shell script that encapsulates a docker container with the Travis CLI (properly) installed which allows for a file to easily be encrypted.

## Dependencies

* Have Docker installed
* Have a command-line that with bash scripting support

## Usage

``` $ bash start.sh <file/directory> <repository>```

**Arguments:**
* **\<directory>**: the **relative** path of the directory that contains the files you want encrypted. Using an absolute path will **not** work at the moment. **Note:** A directory containing more than one file will be compressed before being encrypted.
* **\<repository>**: the GitHub repository that the encrypted files will be tied to.
   * Ex: `alex-greff/travis-cli-encryption-container`

Upon running the script you will be asked by the Travis CLI to input your Github credentials.

**Note #1:** If prompted by Travis to install shell completion reply with `n` for no.

Once the encryption process is completed using the instructions provided during encryption add the decryption command to your `.travis.yml` file and make sure to **only** copy the encrypted files over to the repository as well.

**Note #2:** Due to how `Open SSL` works, if the directory contains more than one file then it must be compressed with tar before being encrypted. Reference [here](https://docs.travis-ci.com/user/encrypting-files/#encrypting-multiple-files) for more information on how to handle it after decryption.

For more information on the general Travis CI encryption/decryption process [this](https://docs.travis-ci.com/user/encrypting-files/) page is an excellent resource.
