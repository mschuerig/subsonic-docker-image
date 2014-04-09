#! /bin/sh -e

image="mschuerig/debian-subsonic"
music="/data/music"
data="/var/local/subsonic"
subsonicport=4040
hostport=4040

container_exposing_port() {
  docker ps --no-trunc \
  | awk "/->${1}\\/tcp/ { print \$1; exit }"
}

running=$( container_exposing_port "$subsonicport" )
if [ -n "$running" ]; then
  echo "Stopping Subsonic container..." >&2
  docker stop "$running"
else
  echo "Subsonic container is not running" >&2
fi

exit 0

