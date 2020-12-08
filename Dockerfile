# Build Autonity in a stock Go builder container
FROM clearmatics/autonity:v0.7.1 as autonity

# Pull Autonity into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY ./secrets /secrets

COPY --from=autonity /usr/local/bin/autonity /usr/local/bin/autonity

EXPOSE 8545 8546 30303 6060

RUN apk update
RUN apk add nano

ENTRYPOINT ["secrets/main.sh"]
