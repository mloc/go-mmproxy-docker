FROM golang:1.20-alpine as build
RUN go install github.com/path-network/go-mmproxy@latest

FROM scratch
COPY --from=build /go/bin/go-mmproxy /usr/local/bin
WORKDIR /data
CMD ["/usr/local/bin/go-mmproxy"]
