FROM golang:1.20-alpine as build

ARG GO_MMPROXY_VERSION=latest

RUN apk add --no-cache git
RUN go install github.com/path-network/go-mmproxy@${GO_MMPROXY_VERSION:-latest}

FROM scratch
COPY --from=build /go/bin/go-mmproxy /usr/local/bin
WORKDIR /data
CMD ["/usr/local/bin/go-mmproxy"]
