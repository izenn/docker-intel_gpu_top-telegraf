#!/bin/bash
topOutput=$(/usr/bin/timeout -k 6 6 /usr/bin/intel_gpu_top -s 5000 -J)
jqOutput=$(echo $topOutput|jq -c .|tail -n 1)
echo $jqOutput|/usr/bin/env python3 /opt/intel_gpu_top-telegraf/intel_gpu_top-convert.py
