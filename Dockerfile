FROM mcr.microsoft.com/dotnet/runtime:10.0

ARG SOURCE_CHANNEL
ARG VERSION

# renovate: release=bookworm depName=curl
ENV CURL_VERSION=7.88.1-10+deb12u14
# renovate: release=bookworm depName=libsqlite3-0
ENV LIBSQLITE_VERSION=3.40.1-2+deb12u2
# renovate: release=bookworm depName=mediainfo
ENV MEDIAINFO_VERSION=23.04-1

RUN apt-get update && \
    apt-get --assume-yes --quiet install \
        curl="${CURL_VERSION}" \
        libsqlite3-0="${LIBSQLITE_VERSION}" \
        mediainfo="${MEDIAINFO_VERSION}" && \
    groupadd --gid=1000 radarr && \
    useradd --gid=1000 --home-dir=/opt/sonarr --no-create-home --shell /bin/bash --uid 1000 sonarr && \
    mkdir /config /downloads /series /opt/sonarr && \
    curl --location --output /tmp/sonarr.tar.gz "https://github.com/Sonarr/Sonarr/releases/download/v${VERSION}/Sonarr.${SOURCE_CHANNEL}.${VERSION}.linux-x64.tar.gz" && \
    tar xzf /tmp/sonarr.tar.gz --directory=/opt/sonarr --strip-components=1 && \
    chown --recursive 1000:1000 /config /downloads /series /opt/sonarr && \
    rm /tmp/sonarr.tar.gz

USER 1000
VOLUME /config /downloads /series
WORKDIR /opt/sonarr

EXPOSE 7878
ENTRYPOINT ["/opt/sonarr/Sonarr"]
CMD ["-data=/config", "-nobrowser"]
