FROM ubuntu:latest

LABEL maintainer=Freender

WORKDIR ./opt/intel-gpu-telegraf

RUN echo Starting. \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends ca-certificates curl gnupg netbase sq wget

RUN curl -s https://repos.influxdata.com/influxdata-archive.key > influxdata-archive.key \
&& echo '943666881a1b8d9b849b74caebf02d3465d6beb716510d86a39f6c8e8dac7515 influxdata-archive.key' | sha256sum -c \
&& cat influxdata-archive.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive.gpg > /dev/null \
&& echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

RUN echo Starting. \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends intel-gpu-tools telegraf \
 && apt-get -q -y full-upgrade \
 && rm -rif /var/lib/apt/lists/* \
 && echo Finished.

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
