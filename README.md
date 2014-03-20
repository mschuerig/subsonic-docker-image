
This repository contains configuration files for building a 
Docker (http://docker.io) image for the Subsonic media streamer.

## Noteworthy:

* Subsonic 4.9 (http://www.subsonic.org)
* Debian/wheezy
* Runs as user subsonic

## Build your own image

```shell
$ docker build -t <your-name>/debian-subsonic debian-subsonic
```

## Run a container with this image

```shell
$ docker run \
  --detach \
  --publish 4040:4040 \
  --volume "/wherever/your/music/is:/var/music:ro" \
  <your-name>/debian-subsonic

```
