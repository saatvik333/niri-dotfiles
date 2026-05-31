#!/bin/bash
# voxtype-toggle.sh
PIDFILE=/tmp/voxtype.pid
if [ -f "$PIDFILE" ]; then
  voxtype record stop
  rm "$PIDFILE"
else
  voxtype record start &
  echo $! > "$PIDFILE"
fi
