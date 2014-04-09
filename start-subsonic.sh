#! /bin/sh -e

music="/data/music"
data="/var/local/subsonic"
port=4040

docker run \
  --detach \
  --publish ${port}:4040 \
  --volume "${music}:/var/music:ro" \
  --volume "${data}:/var/subsonic" \
  mschuerig/debian-subsonic
