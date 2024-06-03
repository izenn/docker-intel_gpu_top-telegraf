FROM debian:latest

WORKDIR .

RUN \
  apt-get update && apt-get install -y curl gpg && \
  curl -s https://repos.influxdata.com/influxdata-archive.key > influxdata-archive.key && \
  cat influxdata-archive.key | \
    gpg --dearmor > /etc/apt/trusted.gpg.d/influxdata-archive.gpg && \
  echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive.gpg] https://repos.influxdata.com/debian stable main' >> /etc/apt/sources.list.d/influxdata.list

RUN apt-get update && apt-get install -y telegraf jq intel-gpu-tools python3
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/telegraf", "--config", "/opt/intel_gpu_top-telegraf/telegraf.conf"]
