FROM mcr.microsoft.com/dotnet/runtime:10.0-alpine3.22

ARG SOURCE_CHANNEL
ARG VERSION

# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ENV CURL_VERSION=8.14.1-r1
# renovate: datasource=repology depName=alpine_3_22/sqlite-libs versioning=loose
ENV SQLITE_LIBS_VERSION=3.49.2-r1

RUN apk add --no-cache --update \
        curl="${CURL_VERSION}" \
        sqlite-libs="${SQLITE_LIBS_VERSION}" && \
    addgroup -g 1000 sonarr && \
    adduser -D -G sonarr -h /opt/sonarr -H -s /bin/sh -u 1000 sonarr && \
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
