# Pull Autonity into a second stage deploy Ubuntu container
FROM ubuntu:20.04

ADD ./files /files
ADD ./autonity /usr/local/bin/autonity
EXPOSE 8545 8546 30303 6060

RUN apt-get update

ENTRYPOINT ["files/main.sh"]
