#!/usr/bin/env bash

set -e

export PATH=$PATH:/opt/benchmark/bin

. /opt/benchmark/suites/utils.sh

sudo rm -rf footprint.tar.bz2
sudo rm -rf *.json

retry-on-error sudo PATH="$PATH" python3 kill.py $OMB/driver-redpanda/redpanda-ack-all-linger-1ms-eod-false.yaml $OMB/workloads/release/full/load.625k.yaml ubuntu /home/ubuntu/.ssh/redpanda_aws
retry-on-error sudo PATH="$PATH" $OMB/bin/benchmark -t swarm -d $OMB/driver-redpanda/redpanda-ack-all-linger-1ms-eod-false.yaml $OMB/workloads/release/full/load.625k.yaml

sudo tar cjf footprint.tar.bz2 $(ls *json)