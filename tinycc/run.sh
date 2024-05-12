#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <arm64_bin>"
    exit 1
fi

DEBUG="${2:-0}" # $2 or default to 0
ARM64_BIN="$1"

if [[ $DEBUG -eq 0 ]]; then
  qemu-aarch64 "$ARM64_BIN"
else
  strace -f qemu-aarch64 "$ARM64_BIN"
fi
RET=$?
rm "$ARM64_BIN"
exit $RET
