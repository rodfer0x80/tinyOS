#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <asm_file>"
    exit 1
fi

ASM_FILE=$1
OBJ_FILE="$(basename "$1" .s).o"
ARM64_BIN="$(basename "$1" .s).arm64"

aarch64-linux-gnu-as -o "$OBJ_FILE" "$ASM_FILE"
aarch64-linux-gnu-gcc -o "$ARM64_BIN"  "$OBJ_FILE"
rm "$ASM_FILE"
rm "$OBJ_FILE"
