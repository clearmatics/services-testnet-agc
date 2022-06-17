#!/bin/sh

echo "Let's start the Node"
echo "container args:" "$@"

cp files/static-nodes.json autonity-chaindata

exec autonity \
        --bakerloo \
        --cache 1024 \
        --http \
        --http.api eth,web3,net,tendermint,txpool,debug,admin \
        --http.vhosts 127.0.0.1 \
        --http.addr 0.0.0.0 \
        --http.corsdomain 127.0.0.1 \
        --ws \
        --ws.api tendermint,eth,web3,admin,debug,personal,txpool,net \
        --ws.origins "*" \
        --ws.addr 0.0.0.0 \
        --metrics \
        --pprof \
        --pprof.addr 0.0.0.0 \
        --networkid  "65010000"\
        --nousb \
        --verbosity 3 \
        --datadir ./autonity-chaindata \
        --syncmode snap \
        "$@"
