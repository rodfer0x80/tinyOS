#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <c_file>"
    exit 1
fi

C_FILE="$1"
ASM_FILE="$(basename "$1" .c).s"

aarch64-linux-gnu-gcc -O2 -S -o "$ASM_FILE" "$C_FILE"
