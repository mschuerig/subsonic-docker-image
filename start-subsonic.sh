#! /bin/sh -e

music="/data/music"
port=4040

docker run \
  --detach \
  --publish ${port}:4040 \
  --volume "${music}:/var/music:ro" \
  mschuerig/debian-subsonic
