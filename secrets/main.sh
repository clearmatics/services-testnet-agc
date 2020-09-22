#!/bin/sh

echo "Let's start the Node"
echo "container args:" "$@"


exec autonity  \
	--syncmode full \
	--cache 1024 \
	--rpc \
	--rpcapi eth,web3,net,tendermint,txpool,debug,admin \
	--rpcvhosts "*" \
	--rpcaddr 0.0.0.0 \
	--rpccorsdomain "*" \
	--ws \
	--wsapi eth,web3,net \
	--wsorigins "*" \
	--metrics \
	--pprof \
	--pprofaddr 0.0.0.0 \
	--networkid 444900 \
	--nousb \
	--debug \
	--verbosity 3\
	"$@"
