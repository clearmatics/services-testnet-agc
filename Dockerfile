# Pull Autonity into a second stage deploy Ubuntu container
FROM ubuntu:latest

ADD ./files /files
ADD ./autonity /usr/local/bin/autonity
EXPOSE 8545 8546 30303 6060

ENTRYPOINT ["files/main.sh"]