# Build Autonity in a stock Go builder container
FROM clearmatics/autonity:v0.4.1 as autonity

# Pull Autonity into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
FROM python:3.8.2-alpine3.11

COPY ./secrets /secrets

COPY --from=autonity /usr/local/bin/autonity /usr/local/bin/autonity

EXPOSE 8545 30303 6060

ENTRYPOINT ["secrets/main.py"]
