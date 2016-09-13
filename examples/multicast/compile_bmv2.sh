#!/bin/bash
source env.sh
COMPILER=$P4C_BM_PATH/p4c_bm/__main__.py
if [ -f "multicast.json" ]
then
    echo "multicast.json exist, remove it"
    rm l2_switch.json
fi

$COMPILER --json multicast.json p4src/multicast.p4
