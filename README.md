# services-testnet-afnc
Autonity Node Client packaged in a Docker Container configured for TestNet

The workflow is:
* add Dockerfile in root directory
* Make any changes
* commit it to GitHub Repo (for example, merge to master
* add release git tag like:
  git tag v0.0.1
  git push --tags
  docker image with this release tag will built automatically

You can use any tags like dev-****** for non-stable releases.
Image with tag latest will build from master branch automatically for every new commit to master.
