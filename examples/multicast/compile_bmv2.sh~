#!/bin/bash
source env.sh
COMPILER=$P4C_BM_PATH/p4c_bm/__main__.py
if [ -f "l2_switch.json" ]
then
    echo "l2_switch.json exist, remove it"
    rm l2_switch.json
fi

$COMPILER --json l2_switch.json p4src/l2_switch.p4
