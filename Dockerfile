FROM mono:6.8.0.96

ARG VERSION

RUN apt-get update && \
    apt-get -y install mediainfo && \
    groupadd -g 1000 sonarr && \
    useradd -d /home/sonarr -g 1000 -m -s /bin/bash -u 1000 sonarr && \
    curl -Lo /tmp/sonarr.deb "http://apt.sonarr.tv/pool/main/n/nzbdrone/nzbdrone_${VERSION}_all.deb" && \
    dpkg -i /tmp/sonarr.deb && \
    mkdir /config /downloads /series && \
    chown -R 1000:1000 /config /downloads /series /opt/sonarr

USER 1000
VOLUME /config /downloads /series
WORKDIR /home/sonarr

EXPOSE 7878
ENTRYPOINT ["mono", "/opt/NzbDrone/NzbDrone.exe", "-data=/config", "-nobrowser"]
