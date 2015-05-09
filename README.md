# debian-subsonic

This repository contains configuration files for building a Docker (http://docker.io) image for the [Subsonic][subsonic] media streamer.

## Noteworthy

* Subsonic 5.2.1 ([http://www.subsonic.org][subsonic])
* Debian/wheezy

## Usage

### Using bind-mount

```shell
$ sudo docker run -d -p 4040:4040 --name subsonic -v /path-to-your-music/:/var/music:ro mschuerig/debian-subsonic
```

### Using data-only containers (recommended)

Please replace `<your-username>` and `<your-email>`, `/path-to-subsonic-data/` and `/path-to-your-music/` in the following instructions.

1. Create two data-only containers, one for the music and one for the configuration.
2. Here is an example Dockerfile for the configuration data

	```Dockerfile
	FROM alpine:3.1
	MAINTAINER <your-username> "<your-email>"

	VOLUME ["/var/subsonic"]

	CMD ["echo", "Data container for Subsonic"]

	```
3. Here is another example Dockerfile for the music

	```Dockerfile
	FROM alpine:3.1
	MAINTAINER <your-username> "<your-email>"

	VOLUME ["/var/music"]

	CMD ["echo", "Music container for Subsonic"]

	```
4. Build the first data-only container, run it and import your data in it. Assuming you created a `subsonicdata/` folder containing the first Dockerfile above, run the following commands.

	```shell
	$ sudo docker build -t <your-username>/subsonicdata subsonicdata/
	$ sudo docker run --name subsonicdata <your-username>/subsonicdata
	# If this is the first time you run Subsonic, you can skip the rest of the commands.
	# If you already run Subsonic, this is how to import your existing data. Be sure to stop Subsonic first.
	$ sudo docker run -it --rm --volumes-from subsonicdata -v /path-to-subsonic-data/:/hostdata <your-username>/subsonicdata sh
	# Once connected to the new container, copy your data from host to volume
	$ cp -r /hostdata/subsonic/* /var/subsonic
	$ exit
	```
5. Build the music data-only container, run it and import your music in it. Assuming you created a `musicdata/` folder containing the second Dockerfile above, run the following commands.

	```shell
	$ sudo docker build -t <your-username>/musicdata musicdata/
	$ sudo docker run --name musicdata <your-username>/musicdata
	# This is how to import your music.
	$ sudo docker run -it --rm --volumes-from musicdata -v /path-to-your-music/:/hostdata <your-username>/musicdata sh
	# Once connected to the new container, copy your music from host to volume
	$ cp -r /hostdata/music/* /var/music
	$ exit
	```
6. Run Subsonic using our two data-only containers. As long as they are present, you can remove the Subsonic container, your configuration and music will stay thanks to the data-only containers.

	```shell
	$ sudo docker run -d -p 4040:4040 --name subsonic --volumes-from subsonicdata --volumes-from musicdata mschuerig/debian-subsonic
	```

## Build your own image

```shell
$ sudo docker build -t <your-name>/debian-subsonic debian-subsonic
```

## Get a pre-built image

A current image is available as a trusted build from the Docker index:

```shell
$ sudo docker pull  mschuerig/debian-subsonic
```

The repository page is at
https://index.docker.io/u/mschuerig/debian-subsonic/

[subsonic]: http://www.subsonic.org
