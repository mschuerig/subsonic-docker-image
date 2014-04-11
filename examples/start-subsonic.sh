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

container_for_image() {
  docker ps -a --no-trunc \
  | awk "\$2 == \"${1}\" || \$2 == \"${1}:latest\" { print \$1; exit }"
}


running=$( container_exposing_port "$http_subsonicport" )
if [ -n "$running" ]; then
  echo "Subsonic container is already running" >&2
else
  container=$( container_for_image "$image" )
  if [ -n "$container" ]; then
    echo "Re-starting Subsonic container" >&2
    docker start "$container"
  else
    echo "Freshly starting Subsonic container" >&2
    docker run \
      --detach \
      --publish ${http_hostport}:${http_subsonicport} \
      --publish ${https_hostport}:${https_subsonicport} \
      --volume "${music}:/var/music:ro" \
      --volume "${data}:/var/subsonic" \
      "${image}" \
      --https-port=$https_subsonicport
  fi
fi

exit 0

