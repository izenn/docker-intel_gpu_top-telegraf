FROM ubuntu:latest

LABEL maintainer=Freender

WORKDIR ./opt/intel-gpu-telegraf

RUN echo Starting. \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends intel-gpu-tools telegraf \
#$ && apt-get -q -y install --no-install-recommends  iputils net-tools vim-enhanced \
 && apt-get -q -y full-upgrade \
 && rm -rif /var/lib/apt/lists/* \
 && echo Finished.

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
