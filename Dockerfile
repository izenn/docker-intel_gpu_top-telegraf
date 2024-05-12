FROM ubuntu:latest

LABEL maintainer=Freender

WORKDIR ./opt/intel-gpu-telegraf

RUN echo Starting. \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends ca-certificates curl gnupg netbase sq wget

RUN /bin/sh -c set -ex && mkdir ~/.gnupg; echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf; for key in 9D539D90D3328DC7D6C8D3B9D8FF8E1F7DF8B07E ; do gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys "$key" ; done # buildkit

RUN echo Starting. \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends intel-gpu-tools telegraf \
 && apt-get -q -y full-upgrade \
 && rm -rif /var/lib/apt/lists/* \
 && echo Finished.

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
