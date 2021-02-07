# Build Autonity in a stock Go builder container
FROM ghcr.io/clearmatics/autonity:v0.7.1 as autonity

LABEL org.opencontainers.image.source https://github.com/clearmatics/services-testnet-agc

# Pull Autonity into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY ./secrets /secrets

COPY --from=autonity /usr/local/bin/autonity /usr/local/bin/autonity

EXPOSE 8545 8546 30303 6060

RUN apk update
RUN apk add nano

# Add dockerize tool -------------------
RUN apk add --no-cache openssl
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz


# CMD secrets/main.sh
ENTRYPOINT ["secrets/main.sh"]

