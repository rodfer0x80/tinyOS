#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: $0 <c_file>"
    exit 1
fi

DEBUG="${2:-0}" # $2 or default to 0
C_FILE="$1"
ASM_FILE="$(basename "$1" .c).s"
ARM64_BIN="$(basename "$1" .c).arm64"

"$PWD"/compiler.sh "$C_FILE"
"$PWD"/assembler.sh "$ASM_FILE"
"$PWD"/run.sh "$ARM64_BIN" $DEBUG
