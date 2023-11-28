#!/bin/bash

echo "Running on node:    $(hostname)"
echo "OVS_HOST:           $(hostname -f)"
echo "In directory:       $(pwd)"
echo "Starting on:        $(date)"

# OVS_HOST=$(hostname -f) && openvscode-server --host $OVS_HOST --accept-server-license-terms --telemetry-level off |sed "s/localhost/$OVS_HOST/g"

# access from a remote PC through VPN the port range should be constricted to 5900-5999
OVS_HOST=$(hostname -f) && openvscode-server --host $OVS_HOST --port 5900-5999 --accept-server-license-terms --telemetry-level off |sed "s/localhost/$OVS_HOST/g"
