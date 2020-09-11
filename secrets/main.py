#!/usr/bin/env python

import argparse
import subprocess
from subprocess import call
import re
import os
print ("lets go!")

print ("Import the genesis")
subprocess.call(['autonity', "--nousb", 'init', 'secrets/genesis.json'])

print ("Let's start the Node")
subprocess.call(['autonity', 
"--gcmode",
"archive",
"--syncmode",
"full",
"--cache",
"1024",
"--rpc",
"--rpcapi",
"eth,web3,net,tendermint,txpool,debug,admin",
"--rpcvhosts",
"*",
"--rpcaddr",
"0.0.0.0",
"--rpccorsdomain",
"*",
"--ws",
"--wsapi",
"eth,web3,net",
"--wsorigins",
"*",
"--metrics",
"--pprof",
"--pprofaddr",
"0.0.0.0",
"--networkid",
"444900",
"--mine",
"--minerthreads",
"1",
"--nousb"
#"--debug",
#"--verbosity",
#"4"
])
