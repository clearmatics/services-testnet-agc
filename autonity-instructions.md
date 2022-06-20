

# Run Autonity

This repository provides an Autonity binary and also a public docker image, both of which you will also be able to run a node with.

### Autonity Go Client


To run an Autonity Bakerloo testnet node, we recommend using a host machine (which can be a physical or a virtual machine) with the following minimum specification:

- Linux (e.g. Ubuntu 20.04 LTS, or another recent system)
- two CPU cores
- 8GB of RAM
- 1024GB of persistent storage space (preferably SSD)



To get the pre-built Autonity Go Client binary and run directly on your host OS:

1. In your workspace create a directory `autonity-chaindata`, which will be used as the data directory for Autonity. In that directory copy is a file `files/static-nodes.json`, which Autonity uses to find other nodes in the network.


2. CD to this repo and copy the binary to `/usr/local/bin`, so it can be accessed by all users (optional):

```bash
cd <PATH_TO_REPO_DIRECTORY>
sudo cp -r autonity /usr/local/bin/autonity
```

You can now run Autonity locally simply with the command `autonity`. For Autonity command-line options see the [Command-line Reference](/reference/cli/).

3. To verify your installation, run 'autonity version` to return the client version and executable build details:

```bash
$ autonity version
Autonity
Version: 0.8.4-internal
Architecture: amd64
Protocol Versions: [66]
Go Version: go1.18
Operating System: linux
GOPATH=
GOROOT=/usr/local/go
```

### Autonity NodeJS Console

The Autonity NodeJS Console is distributed as part of the Autonity Go Client Release.

To run the Console and connect to a node, specify WebSockets as the transport and the IP address and port `8546` of the Autonity client node you will connect to.  Use WS for a local node and WSS for secure connection to a public node on an Autonity network. For example, to connect to a node running on local host:

```bash
./console ws://127.0.0.1:8546
```

On initial running, the console will install web3 and node modules, then initialise the console and display:

  ```javascript
  Welcome to the Autonity node console
  modules: admin:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 tendermint:1.0 txpool:1.0 
  Type web3.<Tab> or autonity.<Tab> to get started
  ```

Currently, the Autonity NodeJS Console is the primary way we interact with Autonity nodes.

### Connect Autonity to a network

Provide the genesis and bootnode files and run Autonity. Autonity will initialise, connect to the network, and sync ledger state.

1. Start autonity with the following command - the blockchain will download in "snap syncmode" - takes about 20mins depending on your connection.

  ``` bash
  IP_ADDRESS="$(curl ifconfig.me)"

  autonity \
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
      --nat extip:$(echo $IP_ADDRESS)
  ```

When Autonity has fully synched up, it will continue to import new chain segments as they are created.
    
### Start a node with the autonity acg docker image

You can also start a node using the services-testnet-agc docker image [here](https://github.com/clearmatics/services-testnet-agc). The docker image runs the binary with all the right flags, genesis and static nodes internally, so is the easiest way to start a node on the Bakerloo network.

This container uses a shared folder for the Autontiy data, autonity-chaindata, so the node database and identity store will be persistent. If you want to start a fresh node with a new identity, make sure you delete the local autonity-chaindata/autonity/nodekey file first.

On the machine that will host your node, download the Autonity Bakerloo testnet Docker image, and create and run a new Docker container from it:

```bash
mkdir autonity-chaindata
IP_ADDRESS="$(curl ifconfig.me)"

docker run --rm --net=host \
--name services-testnet-agc \
-v $(pwd)/autonity-chaindata:/autonity-chaindata \
ghcr.io/clearmatics/services-testnet-agc:v0.8.4-bakerloo \
--nat extip:$(echo $IP_ADDRESS)
```

# Interact with Autonity

## Make calls to Autonity

Navigate to your Autonity NodeJS Console install directory  and initialise a console session, specifying the IP address of the node you will connect to. The connection is made over WebSockets to port 8546:

 ```bash
 ./console ws://<IP-ADDRESS>:8546
 ```
 
If the transport is over WebSockets or WebSockets Secure will depend on your node setup. For connecting to a public node WebSockets Secure (`wss`) is advised._


### Examples

Here are some examples of making calls to the network using the Autonity contract, to retrieve details on the Autonity protocol.

See the [JSON-RPC API Reference](/reference/api/aut/) for all call methods available.

#### Get the block number:

 ```javascript
 await await web3.eth.getBlockNumber()
 ```

#### Get consensus committee size:

 ```javascript
 await autonity.committeeSize().call()
 ```

#### Get all nodes in the consensus committee:

 ```javascript
 await autonity.getCommittee().call()
 ```

#### Get the epochPeriod:

 ```javascript
 await autonity.epochPeriod().call()
 ```

#### Check the treasury fee:

 ```javascript
 await autonity.treasuryFee().call()
 ```

#### Check the newton balance of an account:

 ```javascript
 await autonity.balanceOf('<_addr>').call()
 ```
 
 
## Fund an account with Auton Testnet Faucet

To fund an account with testnet funds go to the Autonity Bakerloo Testnet Auton Faucet. This provides a simple interface to acquire Auton.

1. Go to the Bakerloo Testnet [Faucet](https://faucet.clearmatics.network/) to acquire AUT tokens. 

2. Input your account address.

3. Input the total value of AUT you need. 

	_Note: requests are capped at 1,000,000_.

4. Click the `Go` button to submit the funding request. The AUT will be sent to your account in approximately 10 seconds.


## Submit a transaction to the Bakerloo network

Let me know your address on the Bakerloo network, and I'll fund it with some NEW stake tokens.
To submit transactions to a client node from the Autonity NodeJS Console you need:

- an [installed NodeJS Console](/howto/install-aut/)
- an account on an Autonity network funded with `Auton` to pay for transaction gas costs
- configuration details for the Autonity network you are connecting your console to, i.e. a public or your own node on the Bakerloo testnet
- to provide the following constants:

  - the private key of the account you are using (to unlock the account in the JavaScript environment)
  - the account address (your Ethereum formatted account address prefixed by `0x`)
  - gas (the amount of gas you are providing for the transaction)
  - gas price (the amount of gas you are willing to pay for computing the transaction)

### Setup

1. Navigate to your Autonity NodeJS Console install directory  and initialise a console session, specifying the IP address of the node you will connect to. The connection is made over WebSockets to port 8546:

```bash
./console ws://<IP-ADDRESS>:8546
```


2. Enter the following in the NodeJS Console, specifying the private key of the account submitting the transaction:

```javascript
const privatekey = '<PRIVATE_KEY>';
const account = web3.eth.accounts.wallet.add(privatekey);
const myAddress = web3.utils.toChecksumAddress(account.address);
const gas = 10000000;
const gasPrice = 10000000000;
```

You are now able to submit state affecting transactions to the Autonity network from the configured account. Transactions must be appended with `.send({from: myAddress, gas: gas, gasPrice: gasPrice})`

When a transaction is successful, you will receive a transaction receipt.

### Examples 

Here are some examples of calling Autonity Protocol Contract ERC20 functionality using the Autonity contract.


#### Transfer Newton stake tokens:

```javascript
await autonity.transfer('<_recipient>', <_amount>).send({from: myAddress, gas: gas, gasPrice: gasPrice})
```

#### Approve another account to transfer your Newton stake tokens:

```javascript
await autonity.approve('<spender>', <amount>).send({from: myAddress, gas: gas, gasPrice: gasPrice})
```

#### Transfer Newton stake tokens as an approved account:

```javascript
await autonity.transferFrom('<sender>', '<recipient>', <amount>).send({from: myAddress, gas: gas, gasPrice: gasPrice})
```

# Bonding and unbonding stake

If you want to bond stake to your own node, see the upcoming section on registering a validator, as this must be done first.

## Prerequisites

- a running instance of the Autonity NodeJS Console for submitting transactions from your account configured as described in [Submit a transaction from Autonity NodeJS Console
](/howto/submit-trans/)
- an account on an Autonity network funded with `Auton` to pay for transaction gas costs and a Newton stake token balance >= to the amount being bonded

## Discover registered validators

1. To discover the current set of registered validators in the Autonity network and return their account addresses, call:

 ```bash
 await autonity.getValidators().call() 
 ```

{{% pageinfo %}}
_Note: As described in [Committee member selection](/autonity/consensus/committee/#committee-member-selection) the set of validators in the consensus committee is changed at every block epoch. [Voting power changes](/autonity/consensus/committee/#voting-power-changes) caused by bonding and unbonding stake to a validator are applied at the end of an epoch before the committee selection algorithm for the next epoch's committee is run._

To get the validators in the current consensus committee run:

 ```bash
 await autonity.getCommittee().call() 
 ```
{{% /pageinfo %}}

2. To return metadata about a validator's status and history, query with the validator's address (optional):

 ```bash
 await autonity.getValidator(<addr_>).call() 
 ```

## Bond Newton to validator

Having decided which validator to delegate stake to, verify funds and submit bonding request. 

3. To return your current Newton balance before bonding, query for your account address (optional):

 ```bash
 await autonity.balanceOf('<_addr>').call()
 ```

4. To delegate stake to a validator, submit a bond transaction. Specify the chosen validator account address from the result returned at Step 1 and enter the amount of Newton stake to delegate:

 ```bash
 await autonity.bond('<validator>', <amount>).send({from: myAddress, gas: gas, gasPrice: gasPrice})
 ```
 
 5. The bonding request is tracked in memory until applied at the epoch end. To view the pending bonding request, you can query within a requested block range, specifying the block numbers bounding the range (optional):

 ```bash
 await autonity.getBondingReq('<startId>', <lastId>).call()
 ```

 This will return an array of `Staking` objects.
 
 ## Unbond Newton from validator

Having decided which validator to unbond stake from, submit an unbonding request. 

1. To unbond stake from a validator, submit an unbond transaction. Specify the chosen validator account address and enter the amount of Newton stake to unbond:

 ```bash
 await autonity.unbond('<Validator>', <Amount>).send({from: myAddress, gas: gas, gasPrice: gasPrice})
 ```
 
 2. The unbonding request is tracked in memory until applied at the epoch end (120 blocks). To view the pending unbonding request, you can query within a requested block range, specifying the block numbers bounding the range (optional):

 ```bash
 await autonity.getUnbondingReq('<startId>', <lastId>).call()
 ```

 This will return an array of `Staking` objects.
 
# Register a validator

This page describes the procedure to register your node as a Validator on an Autonity network. Once you do this, you or others can bond stake to your validator, to allow it to enter the consensus committee and start earning rewards validating blocks.


## Prerequisites

- a running instance of the Autonity Go Client you are registering as a validator
- a running instance of the Autonity NodeJS Console attached to your node.
- your account is funded with `Auton` to pay for transaction gas costs. Note that this account will become the validator's `treasury account` - the account address used by the validator entity to submit transactions and calls to the network and the account that will receive the validator's share of staking rewards on reward distribution.
- the registration parameter values:
 - the enode URL of the Autonity Go Client joined to the network that you will use as a validator node
 - the commission rate that the validator will levy on staking rewards received if active in the consensus committee
 - additional metadata string providing human-readable  text for the validator (optional)


## Define registration parameters

1. Set a JavaScript constant for the node's enode URL. Call the web3 `nodeInfo()` method to return the value:

```javascript
	const nodeinfo = await web3.admin.nodeInfo()
```

2. Set a JavaScript constant for the validator commission rate, specifying the percentage you will charge as a commission on staking rewards:

```javascript
	const commissionRate = <COMMISSION_RATE>
```


## Register as a validator

3. To register the node as a validator, submit a registration transaction passing in the method parameters:

```bash
await autonity.registerValidator(nodeinfo.enode, commissionRate, "").send({from: myAddress, gas: gas, gasPrice: gasPrice})
```

*Please note this will register the address of the node as a validator, not the address of the account you used to send the transaction. The address of the node itself and the prvkey are randomly generated when you start the node, but you can replace it with one of your choosing by editing autonity-chaindata/autonity/nodekey before registering the node as a Validator.*

4. To read the validator's registration data from state, first query for the registered validators to return its validator address:

```bash
await autonity.getValidators().call()
```

The method returns an array of the registered validator addresses. The newly registered validator has been appended to the end of the array. You should see something like this:

```javascript
[ '0x21bb01Ae8EB831fFf68EbE1D87B11c85a766C94C',
  '0x8CC985DEd2546e9675546Db6bcF34f87f4A16c56',
  '0x0be4Ee22d794c640366352Ef6CE666E52229886d',
  '0x055A7c97b73Db9649fF03ac50DB0552C959cCa91',
  '0x35379A60fc0f108583d6692cc6D2fa0317cc9724',
  '0x94C1EEe283fac8102dDB08ac0661a268d4977B2d',
  '0x3E33d7C791cD3bf387699Fe91d214401BB5633c0',
  '0x4b2bB31ec442fd0A0500f8Aa40d3b23784E86B14',
  '0x7b9C6CFa98d85F551881908CeeF6c9Af56E6794A' ]
 ```

5. To return the validator registration data, query for your newly registered validator address:

```bash
await autonity.getValidator('<VALIDATOR_ADDRESS>').call()
```

This will return a `Validator` object. You should see something like this:

```bash
> await autonity.getValidator('0x7b9C6CFa98d85F551881908CeeF6c9Af56E6794A').call()
[ '0xd4EdDdE5D1D0d7129a7f9C35Ec55254f43b8E6d4',
  '0x7b9C6CFa98d85F551881908CeeF6c9Af56E6794A',
  'enode://885763a65820b0b2d865863c4daf5973a76253ad272403b57ba7f5a221f42196ffd858ffbd8051ac85a5dc15f710f94fa84f92021280038fe46a3845ff102326@86.143.195.2:30303?discport=0',
  '12',
  '0',
  '0',
  '0',
  '0xbf257BfB97074e5DED578eB919e0Dfa5325393b3',
  '0',
  '',
  '1026378',
  '0',
  treasury: '0xd4EdDdE5D1D0d7129a7f9C35Ec55254f43b8E6d4',
  addr: '0x7b9C6CFa98d85F551881908CeeF6c9Af56E6794A',
  enode: 'enode://885763a65820b0b2d865863c4daf5973a76253ad272403b57ba7f5a221f42196ffd858ffbd8051ac85a5dc15f710f94fa84f92021280038fe46a3845ff102326@86.143.195.2:30303?discport=0',
  commissionRate: '12',
  bondedStake: '0',
  selfBondedStake: '0',
  totalSlashed: '0',
  liquidContract: '0xbf257BfB97074e5DED578eB919e0Dfa5325393b3',
  liquidSupply: '0',
  extra: '',
  registrationBlock: '1026378',
  state: '0' ]
```


_Note: to self-bond stake to your validator node, submit a bond transaction from the account used to submit the registration transaction - i.e. the validator's treasury account address. For how to  do this see the how to [Bond stake](/howto/bond-stake)._
