#!/usr/bin/env bash

# Usage:
# ./flat-api.sh: Generate Code
# ./flat-api.sh -c: Check if the code has already been generated. (For CI)

if ! which sourcery > /dev/null; then
  echo "warning: sourcery not installed, download from https://github.com/krzysztofzablocki/Sourcery"
  exit 1
fi

while getopts c OPT
do
  case $OPT in
    "c" ) CHECK="TRUE" ;;
  esac
done

OUTPUT="Sources/TwitterAPIKit/TwitterAPI+Flat.generated.swift"

sourcery --sources Sources/TwitterAPIKit --templates gen-flat-api.stencil --output ${OUTPUT}

if [ "$CHECK" = "TRUE" ]; then
    if ! git diff --exit-code ${OUTPUT} > /dev/null; then
        echo "Error: There is a difference in ${OUTPUT}. Please generate code and commit." 1>&2
        exit 1
    fi
fi
