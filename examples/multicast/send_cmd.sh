#!/bin/bash
source env.sh
json_file="multicast.json"

if [ -f "$json_file" ]
then
  # insert default rule for p4 switch
    $BMV2_PATH/tools/runtime_CLI.py --json $json_file --thrift-port 22222 --pre SimplePreLAG < commands.txt	
else
    echo "$json_file not found."
fi
