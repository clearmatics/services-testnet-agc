# services-testnet-afnc
Autonity Node Client packaged in a Docker Container configured for TestNet

The workflow is:
* add Dockerfile in root directory
* Make any changes
* commit it to GitHub Repo (for example, merge to master
* add release git tag like:

`git tag v0.0.1`

`git push --tags`

docker image with this release tag will built automatically

You can use any tags like dev-****** for non-stable releases.
Image with tag latest will build from master branch automatically for every new commit to master.



# Autonity Docker

**This tutorial explains how to initalise Autonity with a genesis file and launch Autonity within a docker container. Hence, this set of instructions can be used to run an Autonity node either locally or in a cloud VM instance.**

### Setup

1. Update [genesis.json](./secrets/genesis.json) with the genesis file of the network you wish to join.
2. In order to use a specific version of Autonity, edit line 3 of [Dockerfile](https://github.com/clearmatics/autonity-docker/blob/master/Dockerfile) as follows:
```console
FROM clearmatics/autonity:v<major-minor-patch> as autonity
```

### Run the Docker image

1. Build the docker image:
```console
docker build -t autonity-docker .```

2. Start the docker image:
```console
docker run -d --net=host -ti autonity-docker
```

Due to the `--net=host` flag, the docker container will share the same ports as the host machine it is running on.

3. [Optional] Test your setup:
```console
# Install curl
apt install curl

# Send a request to your running node
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}' 127.0.0.1:8545
```

### Running on a cloud VM

This image has been successfully tested on a GCP VM running Debian, as well as on an AWS VM running Amazon Linux. If you want to connect to the node from outside the VM, make sure to configure the firewall to allow incoming connections to the following ports:

`TCP 8545, 8546, 30303, 6060` and `FTP 30303`

Make sure that the VM you are using has at least a 100Gb boot disk to store the blockchain. When initially syncing up with the network (which can take most of a day), it is recommended to use a VM with two virtual CPUs instead of one, so it does not become overloaded. You should downgrade to one once the node had caught up with the rest of the network.

To add the new node as a participant then as a validator once it has caught up with the network, use system operator.
