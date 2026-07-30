#!/usr/bin/env bash
set -euo pipefail

QEMU=qemu-system-x86_64
IMG=disk.img

case "${1:-window}" in
  window)
    exec "$QEMU" -drive format=raw,file="$IMG"
    ;;
  curses)
    exec "$QEMU" -drive format=raw,file="$IMG" -display curses
    ;;
  debug)
    exec "$QEMU" -drive format=raw,file="$IMG" \
        -no-reboot -no-shutdown -d int,cpu_reset
    ;;
  *)
    echo "usage: $0 [window|curses|debug]" >&2
    exit 1
    ;;
esac