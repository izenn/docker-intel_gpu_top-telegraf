# Intel iGPU utilization to Grafana REWRITE: intel_gpu_top-telegraf

<img width=150px height=150px src="https://github.com/brianmiller/docker-templates/raw/master/intel-gpu-telegraf/intel_telegraf.png"></img>

This is a rewrite of intel-gpu-telegraf moving from a fedora base to debian, sending ALL stats from intel_gpu_top to influxdb, changing telegraf to authenticate using influxdb2 tokens, and moving from json to line protocol when sending data through telegraf

This container requires that /dev/dri (the GPU) is piped to the container. You will also need to either run the container with CAP_PERFMON or privileged.

Ultimately the goal was to display GPU statistics via Grafana.

<br>

#### required telegraf.conf modifications:
##### `urls`: This is the address to the influxdb server ex: `urls = ["http://192.168.1.150:8086"]`  
##### `token`: This is the api token generated from the influxdb dashboard
##### `organization`: This is the organization id or name setup in influxdb
##### `bucket`: This is the bucket that telegraf will be sending data to

<br>

#### docker-compose.yml modifications:
##### `volumes`: this is the path to the scripts and telegraf configuration.  this only needs to be changed if you move the intel_gpu_top-telegraf subdirectory

## Starting the container
The recommended way to start the container is to build before starting:
`docker compose build --no-cache`
then
`docker compose up -d`
This is because it will force docker to update the base layer and installed packages in order to squash bugs and security issues

### Credits
https://github.com/shubhamcoc/optional_flattening_of_json for the majority of the code needed for flattening the json output from intel_gpu_top