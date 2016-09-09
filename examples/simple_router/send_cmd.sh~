#!/bin/bash
source env.sh
json_file="simple_router.json"

if [ -f "$json_file" ]
then
  # insert default rule for p4 switch
    $BMV2_PATH/tools/runtime_CLI.py --json $json_file --thrift-port 9090 --pre SimplePre < commands.txt	
else
    echo "$json_file not found."
fi
