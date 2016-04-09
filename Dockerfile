FROM debian:stable
MAINTAINER Yves Jacolin <yjacolin@free.fr>

ENV VERSION 2016-04-02
ENV TINYOWS_VERSION=master

RUN apt-get update
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qqy git cmake \
    build-essential autoconf flex \
    libxml2-dev libfcgi-dev libpq-dev \
    apache2 apache2-threaded-dev apache2-mpm-worker apache2

RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -qqy postgis

RUN mkdir /build 
RUN mkdir /tinyows

RUN cd /build && git clone https://github.com/mapserver/tinyows.git && \
    cd /build/tinyows && git checkout ${TINYOWS_VERSION} && \
    cd /build/tinyows/ && autoconf && ./configure && \
    make && make install && cp tinyows /usr/lib/cgi-bin/ && ldconfig && \
    rm -Rf /build/tinyows

    #cp /build/tinyows/tinyows.xml /tinyows/ && \

ADD tinyows.conf /etc/apache2/sites-available/tinyows.conf
RUN a2dissite 000-default
RUN a2ensite tinyows

RUN apt-get purge -y software-properties-common build-essential cmake ; \
    apt-get purge -y libfcgi-dev liblz-dev libpng-dev libgdal-dev libgeos-dev \
    libpixman-1-dev libsqlite0-dev libcurl4-openssl-dev \
    libaprutil1-dev libapr1-dev libjpeg-dev libdpkg-dev \
    libdb5.3-dev libtiff5-dev libpcre3-dev ; \
    apt-get autoremove -y ; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/partial/* /tmp/* /var/tmp/*

WORKDIR /tinyows
VOLUME ["/tinyows"]

EXPOSE 80

CMD ["apache2ctl", "-DFOREGROUND"]
