# services-testnet-agc

Autonity Go Client for Autonity nodes, packaged in a Docker Container configured for the Bakerloo testnet.

Workflow:
* add Dockerfile in root directory
* Make any changes
* commit it to GitHub Repo (for example, merge to master
* add release git tag like:

`git tag v0.8.0-bakerloo01`

`git push --tags`

Docker images with this release tag will be built automatically by GitHub Actions.

You can use any tags like dev-****** for non-stable releases.
Image with tag latest will build from master branch automatically for every new commit to master.

## Use the docker image:

This container uses a shared folder for the Autontiy data, so the node database and identity store will be persistent. If you want to start a fresh node with a new identity, make sure you delete the local `autonity-chaindata/autonity/nodekey` directory first.

```bash
IP_ADDRESS="$(curl ifconfig.me)"

docker run --rm --net=host \
--name services-testnet-agc \
-v $(pwd)/autonity-chaindata:/autonity-chaindata \
 ghcr.io/clearmatics/services-testnet-agc:v0.8.0-bakerloo01 \
--nat extip:$(echo $IP_ADDRESS)
```

## [Optional] Test your setup:
```console
# Install curl
apt install curl

# Send a request to your running node
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}' 127.0.0.1:8545
```

## Running on a cloud VM

This image has been successfully tested on a GCP VM running Debian, as well as on an AWS VM running Amazon Linux. If you want to connect to the node from outside the VM, make sure to configure the firewall to allow incoming connections to the following ports:

`TCP 8545, 8546, 30303, 6060`

Make sure that the VM you are using has at least a 100Gb boot disk to store the blockchain. When initially syncing up with the network (which can take most of a day), it is recommended to use a VM with two virtual CPUs instead of one, so it does not become overloaded. You should downgrade to one once the node had caught up with the rest of the network.

To add the new node as a participant then as a validator once it has caught up with the network, use system operator.
