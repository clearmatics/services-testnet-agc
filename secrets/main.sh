#!/bin/sh

echo "Let's start the Node"
echo "container args:" "$@"


exec autonity  \
        --cache 1024 \
        --http\
        --http.api eth,web3,net,tendermint,txpool,debug,admin \
        --http.vhosts  "*" \
        --http.addr 0.0.0.0 \
        --http.corsdomain "*" \
        --ws \
        --ws.api tendermint,console,eth,web3,admin,debug,miner,personal,txpool,net \
        --ws.origins "*" \
        --ws.addr 0.0.0.0 \
        --metrics \
        --pprof \
        --pprof.addr 0.0.0.0 \
        --networkid 444900 \
        --nousb \
        --debug \
        --verbosity 3\
        "$@"
