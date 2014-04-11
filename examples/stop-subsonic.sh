#! /bin/sh -e

image="mschuerig/debian-subsonic"
music="/data/music"
data="/var/local/subsonic"
http_subsonicport=4040
http_hostport=4040
https_subsonicport=4443
https_hostport=4443

container_exposing_port() {
  docker ps --no-trunc \
  | awk "/->${1}\\/tcp/ { print \$1; exit }"
}

running=$( container_exposing_port "$http_subsonicport" )
if [ -n "$running" ]; then
  echo "Stopping Subsonic container..." >&2
  docker stop "$running"
else
  echo "Subsonic container is not running" >&2
fi

exit 0

