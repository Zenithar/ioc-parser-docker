FROM multiarch/alpine:x86_64-latest-stable
MAINTAINER Thibault NORMAND <me@zenithar.org>

RUN apk add --update python py-pip \
    && rm -rf /var/apk/* \
    && pip install --upgrade pip \
    && addgroup python \
    && adduser -s /bin/false -G python -S -D python

ADD https://github.com/armbues/ioc_parser/archive/master.tar.gz /
RUN tar zxvf master.tar.gz \
    && rm -f master.tar.gz \
    && mv /ioc_parser-master /app \
    && cd /app \
    && pip install -r requirements.txt \
    && mkdir /data

VOLUME     "/data"

USER       python
WORKDIR    "/data"
ENTRYPOINT ["/app/iocp.py"]
CMD        ["-h"]
