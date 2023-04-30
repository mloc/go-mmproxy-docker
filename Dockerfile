FROM golang:1.20-alpine as build

ARG GO_MMPROXY_VERSION=latest

RUN apk add --no-cache git
RUN go install github.com/path-network/go-mmproxy@${GO_MMPROXY_VERSION:-latest}

FROM alpine:3.17
COPY --from=build /go/bin/go-mmproxy /usr/local/bin/
COPY default/path-prefixes.txt /etc/path-prefixes.txt
WORKDIR /data
ENTRYPOINT ["go-mmproxy"]
CMD ["--allowed-subnets", "/etc/path-prefixes.txt"]
