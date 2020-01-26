FROM mono:6.8.0.96

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install mediainfo sqlite3 && \
    groupadd --gid=1000 sonarr && \
    useradd --gid=1000 --home-dir=/opt/sonarr --no-create-home --shell /bin/bash --uid 1000 sonarr && \
    curl --location --output /tmp/sonarr.deb "http://apt.sonarr.tv/pool/main/n/nzbdrone/nzbdrone_${VERSION}_all.deb" && \
    dpkg --install /tmp/sonarr.deb && \
    mkdir /config /downloads /series && \
    chown --recursive 1000:1000 /config /downloads /series

USER 1000
VOLUME /config /downloads /series
WORKDIR /opt/NzbDrone

EXPOSE 7878
ENTRYPOINT ["mono", "/opt/NzbDrone/NzbDrone.exe", "-data=/config", "-nobrowser"]
