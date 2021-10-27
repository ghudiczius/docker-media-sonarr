FROM mono:6.12.0.107

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install mediainfo sqlite3 && \
    groupadd --gid=1000 sonarr && \
    useradd --gid=1000 --home-dir=/opt/sonarr --no-create-home --shell /bin/bash --uid 1000 sonarr && \
    mkdir /config /downloads /series && \
    curl --location --output /tmp/sonarr.deb "https://apt.sonarr.tv/debian/pool/main/s/sonarr/sonarr_${VERSION}_all.deb" && \
    dpkg --install /tmp/sonarr.deb && \
    chown --recursive 1000:1000 /config /downloads /series && \
    rm /tmp/sonarr.deb

USER 1000
VOLUME /config /downloads /series
WORKDIR /opt/sonarr

EXPOSE 7878
ENTRYPOINT ["mono"]
CMD ["/usr/lib/sonarr/bin/Sonarr.exe", "-data=/config", "-nobrowser"]
