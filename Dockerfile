FROM golang:1.20-alpine as build

ARG GO_MMPROXY_VERSION=latest

RUN apk add --no-cache git
RUN go install github.com/path-network/go-mmproxy@${GO_MMPROXY_VERSION:-latest}

FROM scratch
COPY --from=build /go/bin/go-mmproxy /usr/local/bin
RUN mkdir -p /etc/default/go-mmproxy
COPY default/path-prefixes.txt /etc/default/go-mmproxy
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/go-mmproxy"]
CMD ["--allowed-subnets", "/etc/default/go-mmproxy/path-prefixes.txt"]
