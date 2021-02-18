FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV RESYNC_PERIOD 12h
ENV SYNC false

RUN apt-get update \
  && apt-get install --no-install-recommends -y apt-mirror apache2 \
  && mv /etc/apt/mirror.list / \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

ADD mirror.list /etc/apt/mirror.list
ADD apache2.conf /etc/apache2/apache2.conf
EXPOSE 80
COPY setup.sh /setup.sh

VOLUME ["/var/spool/apt-mirror"]
CMD ["/bin/bash", "setup.sh"]
