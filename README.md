# Sonarr

Simple docker image for Sonarr without any bloat, built on the official mono image. Sonarr runs as user `sonarr` with `uid` and `gid` `1000` and listens on port `8989`.

## Usage

```sh
docker run --rm registry.gitlab.jmk.hu/media/sonarr:<VERSION> \
  -p 8989:8989 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads \
  -v path/to/movies:/movies
```

or

```sh
docker run --rm ghudiczius/sonarr:<VERSION> \
  -p 8989:8989 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads \
  -v path/to/movies:/movies
```
