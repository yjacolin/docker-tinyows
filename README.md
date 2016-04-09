# TinyOWS

[![Docker Pulls](https://img.shields.io/docker/pulls/yjacolin/docker-tinyows.svg)](https://hub.docker.com/r/yjacolin/docker-tinyows/)

[![Travis](https://travis-ci.org/yjacolin/docker-tinyows.svg)](https://travis-ci.org/yjacolin/docker-tinyows)

For more information, see TinyOWS repository: 
https://github.com/mapserver/tinyows

## Install
```
$ git clone
$ docker build -t yjacolin/tinyows .
```

## Run mapcache

Get help:
```
$ ls somewhere
  tinyows.conf
$ docker run -d -p 8281:80 -v somewhere:/tinyows --name tinyows yjacolin/tinyows
$ docker start tinyows
$ docker stop tinyows
```

## TODO

* fastcgi

