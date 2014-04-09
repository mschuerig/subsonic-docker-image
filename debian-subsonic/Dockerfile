FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

# Create a new user account with UID/GID at least 10000.
# This makes it easier to keep host and docker accounts apart.
RUN useradd --home /var/subsonic -M subsonic -K UID_MIN=10000 -K GID_MIN=10000
RUN mkdir -p /var/subsonic && chown subsonic /var/subsonic && chmod 0770 /var/subsonic

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

RUN apt-get update
RUN apt-get install --yes --no-install-recommends --no-install-suggests openjdk-7-jre-headless locales
RUN apt-get clean

ADD http://downloads.sourceforge.net/project/subsonic/subsonic/4.9/subsonic-4.9.deb?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fsubsonic%2Ffiles%2Fsubsonic%2F4.9%2Fsubsonic-4.9.deb%2Fdownload%3Fuse_mirror%3Dautoselect&ts=1395340045&use_mirror=garr /tmp/subsonic-4.9.deb

RUN dpkg -i /tmp/subsonic-4.9.deb && rm -f /tmp/*.deb

ADD startup.sh /startup.sh

EXPOSE 4040

USER subsonic

CMD []
ENTRYPOINT ["/startup.sh"]
