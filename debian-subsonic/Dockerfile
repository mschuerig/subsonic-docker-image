FROM debian:jessie

MAINTAINER michael@schuerig.de

ENV DEBIAN_FRONTEND noninteractive

# Create a new user account with UID/GID at least 10000.
# This makes it easier to keep host and docker accounts apart.
RUN useradd --home /var/subsonic -M subsonic -K UID_MIN=10000 -K GID_MIN=10000 && \
    mkdir -p /var/subsonic && chown subsonic /var/subsonic && chmod 0770 /var/subsonic

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    apt-get update && \
    apt-get dist-upgrade --yes --no-install-recommends --no-install-suggests && \
    apt-get install --yes --no-install-recommends --no-install-suggests openjdk-7-jre-headless locales && \
    apt-get clean

ENV SUBSONIC_VERSION 6.0

ADD http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION.deb?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsubsonic%2Ffiles%2Fsubsonic%2F$SUBSONIC_VERSION%2F&ts=1421842428&use_mirror=optimate /tmp/subsonic-$SUBSONIC_VERSION.deb
RUN dpkg -i /tmp/subsonic-$SUBSONIC_VERSION.deb && rm -f /tmp/*.deb

# Create hardlinks to the transcoding binaries.
# This way we can mount a volume over /var/subsonic.
# Apparently, Subsonic does not accept paths in the Transcoding settings.
# If you mount a volume over /var/subsonic, create symlinks
# <host-dir>/var/subsonic/transcode/ffmpeg -> /usr/local/bin/ffmpeg
# <host-dir>/var/subsonic/transcode/lame -> /usr/local/bin/lame
RUN ln /var/subsonic/transcode/ffmpeg /var/subsonic/transcode/lame /usr/local/bin

VOLUME /var/subsonic

COPY startup.sh /startup.sh

EXPOSE 4040

USER subsonic

CMD []
ENTRYPOINT ["/startup.sh"]
