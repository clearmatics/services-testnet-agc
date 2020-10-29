# services-testnet-afnc

Autonity Go Client for Autonity nodes, packaged in a Docker Container configured for the Bakerloo testnet.

Workflow:
* add Dockerfile in root directory
* Make any changes
* commit it to GitHub Repo (for example, merge to master
* add release git tag like:

`git tag v0.4.1.1`

`git push --tags`

docker image with this release tag will built automatically

You can use any tags like dev-****** for non-stable releases.
Image with tag latest will build from master branch automatically for every new commit to master.

## Use the docker image:

To run with mining and full sync disabled:

`docker run -d --net=host --name services-testnet-afnc clearmatics/services-testnet-afnc:v0.6.0.4`

To run with mining enabled and full sync enabled (so can become a validator node):

`docker run -d --net=host --name services-testnet-afnc clearmatics/services-testnet-afnc:v0.6.0.4 --mine --minerthreads 1	--syncmode full`

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
