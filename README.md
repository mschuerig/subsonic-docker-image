
This repository contains configuration files for building a 
Docker (http://docker.io) image for the Subsonic media streamer.

## Noteworthy

* Subsonic 5.2.1 (http://www.subsonic.org)
* Debian/wheezy

## Build your own image

```shell
$ docker build -t <your-name>/debian-subsonic debian-subsonic
```

## Get a pre-built image

A current image is available as a trusted build from the Docker index:

```shell
$ docker pull  mschuerig/debian-subsonic
```

The repository page is at
https://index.docker.io/u/mschuerig/debian-subsonic/


## Run a container with this image

```shell
$ docker run \
  --detach \
  --publish 4040:4040 \
  --volume "/wherever/your/music/is:/var/music:ro" \
  <your-name>/debian-subsonic

```
